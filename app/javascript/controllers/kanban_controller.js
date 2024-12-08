import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs";

/**
 * Kanban Controller
 * Manages drag-and-drop functionality for task cards across kanban columns
 * and handles status updates via API calls.
 */
export default class extends Controller {
  static targets = ["items"]

  /** Available task statuses */
  static statuses = {
    ABANDONED: "abandoned",
    NOT_STARTED: "not_started",
    IN_PROGRESS: "in_progress",
    COMPLETE: "complete"
  }

  connect() {
    this.initializeSortable()
  }

  /**
   * Initializes Sortable.js for each kanban column
   * @private
   */
  initializeSortable() {
    this.itemsTargets.forEach(items => {
      new Sortable(items, {
        group: "kanban",
        animation: 150,
        dragClass: "kanban-item--dragging",
        ghostClass: "kanban-item--ghost",
        onEnd: this.handleDragEnd.bind(this),
      })
    })
  }

  /**
   * Handles the end of a drag operation
   * @param {Event} event - The drag end event
   * @private
   */
  async handleDragEnd(event) {
    const campaignId = event.item.dataset.campaignId
    const taskId = event.item.dataset.taskId
    const newStatus = event.to.dataset.status

    try {
      await this.updateTaskStatus(campaignId, taskId, newStatus)
      this.showSuccessMessage()
    } catch (error) {
      console.error("Error updating task status:", error)
      this.showErrorMessage()
      // Revert the drag operation
      event.from.appendChild(event.item)
    }
  }

  /**
   * Updates task status via API
   * @param {string} campaignId - The campaign ID
   * @param {string} taskId - The task ID
   * @param {string} newStatus - The new status
   * @returns {Promise} - The fetch promise
   * @private
   */
  async updateTaskStatus(campaignId, taskId, newStatus) {
    const response = await fetch(`/campaigns/${campaignId}/tasks/${taskId}/update_status`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": this.getCsrfToken(),
      },
      body: JSON.stringify({ task: { status: newStatus } }),
    })

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`)
    }

    return response
  }

  /**
   * Shows a success message using Turbo Streams
   * @private
   */
  showSuccessMessage() {
    const event = new CustomEvent("flash", {
      detail: { type: "success", message: "Task status updated successfully" }
    })
    window.dispatchEvent(event)
  }

  /**
   * Shows an error message using Turbo Streams
   * @private
   */
  showErrorMessage() {
    const event = new CustomEvent("flash", {
      detail: { type: "error", message: "Failed to update task status" }
    })
    window.dispatchEvent(event)
  }

  /**
   * Gets the CSRF token from the meta tag
   * @returns {string} - The CSRF token
   * @private
   */
  getCsrfToken() {
    return document.querySelector('meta[name="csrf-token"]')?.content
  }
}
