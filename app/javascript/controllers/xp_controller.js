import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["progressBar", "points"]

  connect() {
    this.loadXp()
  }

  async loadXp() {
    try {
      const response = await fetch('/xp/current')
      const data = await response.json()
      this.updateXp(data.points, data.maxPoints)
    } catch (error) {
      console.error("Error loading XP data:", error)
    }
  }

  updateXp(points, maxPoints) {
    const percentage = (points / maxPoints) * 100
    this.progressBarTarget.style.width = `${percentage}%`
    this.pointsTarget.textContent = `${points}/${maxPoints} XP`
  }
}
