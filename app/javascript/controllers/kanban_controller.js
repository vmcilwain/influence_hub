import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs";

// Connects to data-controller="kanban"
export default class extends Controller {
  static targets = ["items"]; // Targets the kanban-items containers

  connect() {
    // Initialize Sortable for each items container
    this.itemsTargets.forEach((items) => {
      new Sortable(items, {
        group: "kanban", // Enable cross-column dragging
        animation: 150,
        onEnd: this.updateTaskStatus.bind(this), // Handle the drag event
      });
    });
  }

  updateTaskStatus(event) {
    const campaignId = event.item.dataset.campaignId // Get the dragged tasks campaign ID
    const taskId = event.item.dataset.taskId; // Get the dragged task's ID
    const newStatus = event.to.dataset.status; // Get the new column's status

    // Update task status via a PATCH request
    fetch(`/campaigns/${campaignId}/tasks/${taskId}/update_status`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
      body: JSON.stringify({ task: { status: newStatus } }),
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error("Failed to update task status");
        }
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  }
}
