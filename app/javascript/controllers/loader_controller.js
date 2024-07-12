import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["loader"]

  connect() {
    this.showLoader()
    window.addEventListener('load', this.hideLoader.bind(this))
    document.addEventListener('turbo:load', this.hideLoader.bind(this))
  }

  showLoader() {
    this.loaderTarget.style.display = 'flex'
  }

  hideLoader() {
    setTimeout(() => {
      this.loaderTarget.classList.add('hide')
      setTimeout(() => {
        this.loaderTarget.style.display = 'none'
        this.loaderTarget.classList.remove('hide')
      }, 300) // Duration of the fade-out animation
    }, 300) // Minimum duration to show the loader
  }
}
