// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

import "trix"
import "@rails/actiontext"

// Set default options for Flatpickr globally
import flatpickr from "flatpickr"
flatpickr.defaultConfig = {
  altInput: true,
  altFormat: "F j, Y",
  dateFormat: "Y-m-d",
  minDate: "today",
  allowInput: true,
  disableMobile: true
}
