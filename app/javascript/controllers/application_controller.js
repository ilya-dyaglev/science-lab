import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log(`Connected: ${this.identifier}`)
  }

  showAlert(message) {
    alert(message)
  }

}
