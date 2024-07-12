import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]

  connect() {
    this.itemTargets.forEach(item => {
      item.addEventListener("click", this.handleClick.bind(this))
    })
  }

  handleClick(event) {
    const link = event.currentTarget.querySelector("a")
    if (link) {
      window.location = link.href
    }
  }
}
