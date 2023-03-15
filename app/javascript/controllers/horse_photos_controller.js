import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="horse-photos"
export default class extends Controller {
  connect() {
    console.log("Hello")
  }
}
