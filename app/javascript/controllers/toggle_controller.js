import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = [ "form" ]

  open(event) {
    // if the form has the class d-none
    if (this.formTarget.classList.contains("d-none")) {
      // we remove the class
      this.formTarget.classList.remove("d-none")
    } else {
      // add the class
      this.formTarget.classList.add("d-none")
    }
  }
}
