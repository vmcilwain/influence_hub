import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-modal"
export default class extends Controller {
  connect() {
    // Show the dialog
    if (!this.element.open) {
      this.element.showModal();
    }

    // Store the element that had focus before modal opened
    this.previousActiveElement = document.activeElement;

    // Focus the first input after a short delay to ensure the dialog is ready
    setTimeout(() => {
      const firstInput = this.element.querySelector('input[name*="[description]"]');
      if (firstInput) {
        firstInput.focus();
      }
    }, 50);

    // Handle escape key and dialog close events
    this.boundKeyDown = this.handleKeyDown.bind(this);
    this.boundDialogClose = this.handleDialogClose.bind(this);
    document.addEventListener('keydown', this.boundKeyDown);
    this.element.addEventListener('close', this.boundDialogClose);
  }

  disconnect() {
    // Remove event listeners
    if (this.boundKeyDown) {
      document.removeEventListener('keydown', this.boundKeyDown);
    }
    if (this.boundDialogClose) {
      this.element.removeEventListener('close', this.boundDialogClose);
    }

    // Close dialog if it's open
    if (this.element.open) {
      this.element.close();
    }

    // Restore focus
    if (this.previousActiveElement) {
      this.previousActiveElement.focus();
    }
  }

  handleKeyDown(event) {
    if (event.key === 'Escape') {
      this.hideModal();
    }
  }

  handleDialogClose(event) {
    // Clean up the turbo frame when dialog closes
    this.cleanupTurboFrame();
  }

  hideModal() {
    // Close the dialog
    this.element.close();

    // Remove event listeners
    if (this.boundKeyDown) {
      document.removeEventListener('keydown', this.boundKeyDown);
    }
    if (this.boundDialogClose) {
      this.element.removeEventListener('close', this.boundDialogClose);
    }

    // Clean up the turbo frame
    this.cleanupTurboFrame();

    // Restore focus
    if (this.previousActiveElement) {
      this.previousActiveElement.focus();
    }
  }

  cleanupTurboFrame() {
    // Find the turbo frame
    const frame = document.querySelector('#task-edit-modal');
    if (frame) {
      // Clear the frame's content
      frame.innerHTML = '';
    }
  }
}
