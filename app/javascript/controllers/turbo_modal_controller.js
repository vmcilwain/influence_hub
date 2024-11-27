import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-modal"
export default class extends Controller {
  connect() {
    // Show overlay when modal opens
    document.querySelector('.turbo-frame-overlay').style.display = 'block';
  }

  hideModal() {
    // Hide overlay
    document.querySelector('.turbo-frame-overlay').style.display = 'none';
    // Add hidden class back to modal
    this.element.classList.add('hidden');
  }
}
