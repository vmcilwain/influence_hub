import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

export default class extends Controller {
  connect() {
    console.log("Datepicker controller connected")
    
    this.flatpickr = flatpickr(this.element, {
      dateFormat: "Y-m-d",
      minDate: "today",
      defaultDate: "today",
      altInput: true,
      altFormat: "F j, Y",
      allowInput: true,
      disableMobile: true,
      monthSelectorType: "static",
      position: "auto",
      onChange: (selectedDates, dateStr) => {
        console.log("Date selected:", dateStr)
      }
    })
  }

  disconnect() {
    if (this.flatpickr) {
      this.flatpickr.destroy()
    }
  }
}
