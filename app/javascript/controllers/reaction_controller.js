import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["reactionCard", "reactionElementsContainer"]

  connect() {
    this.reactionCardTargets.forEach(card => {
      card.addEventListener("click", () => this.showReactionElements(card.dataset.reactionId))
    })
  }

  async showReactionElements(reactionId) {
    try {
      const response = await fetch(`/reactions/${reactionId}/elements`, {
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content")
        }
      })
      if (!response.ok) {
        throw new Error("Network response was not ok")
      }
      const data = await response.json()

      // Clear previous elements
      this.reactionElementsContainerTarget.innerHTML = ""

      // Populate modal with elements
      data.forEach(element => {
        const elementCard = `
          <div class="card text-center mb-3">
            <img src="${element.image_url}" class="card-img-top" alt="${element.name}">
            <div class="card-body">
              <h5 class="card-title">${element.name}</h5>
            </div>
          </div>
        `
        this.reactionElementsContainerTarget.insertAdjacentHTML("beforeend", elementCard)
      })

      // Show modal
      $("#reactionElementsModal").modal("show")
    } catch (error) {
      console.error("Error fetching reaction elements:", error)
    }
  }
}
