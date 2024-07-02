import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["elementList", "result", "combineButton", "clearButton", "dropzoneArea"]

    connect() {
        this.toggleButtons()
        this.togglePlaceholder()
    }

    dragStart(event) {
        event.dataTransfer.setData("elementId", event.target.dataset.elementId)
        event.dataTransfer.setData("elementName", event.target.dataset.elementName)
    }

    allowDrop(event) {
        event.preventDefault()
    }

    dropElement(event) {
        event.preventDefault()
        const elementId = event.dataTransfer.getData("elementId")
        const elementName = event.dataTransfer.getData("elementName")
        const input = this.elementListTarget.querySelector(`input[data-element-id="${elementId}"]`)
        if (input) {
            input.value = parseInt(input.value) + 1
        } else {
            const newInput = document.createElement('input')
            newInput.type = 'hidden'
            newInput.dataset.elementId = elementId
            newInput.dataset.elementName = elementName
            newInput.value = 1
            this.elementListTarget.appendChild(newInput)
        }

        let existingElement = this.dropzoneAreaTarget.querySelector(`div[data-element-id="${elementId}"]`)
        if (existingElement) {
            const counter = existingElement.querySelector('.counter')
            counter.textContent = parseInt(counter.textContent) + 1
        } else {
            const newElement = document.createElement('div')
            newElement.className = 'element-block dropped-element'
            newElement.dataset.elementId = elementId
            newElement.dataset.elementName = elementName
            newElement.draggable = true
            newElement.ondragstart = (e) => this.dragStart(e)
            newElement.innerHTML = `
            ${elementName}<span class="counter">1</span>
                <span class="remove-icon" data-action="click->lab#removeElement">&times;</span>
                `
            this.dropzoneAreaTarget.appendChild(newElement)
        }

        this.togglePlaceholder()
        this.toggleButtons()
    }

    removeElement(event) {
        const elementBlock = event.target.closest('.dropped-element')
        const elementId = elementBlock.dataset.elementId
        const input = this.elementListTarget.querySelector(`input[data-element-id="${elementId}"]`)

        if (input) {
            input.value = parseInt(input.value) - 1
            if (parseInt(input.value) === 0) {
                input.remove()
                elementBlock.remove()
                this.togglePlaceholder()
            } else {
                const counter = elementBlock.querySelector('.counter')
                counter.textContent = input.value
            }
        }

        this.toggleButtons()
    }

    async combine() {
        const selectedElements = Array.from(this.elementListTarget.querySelectorAll('input[type="hidden"]'))
            .filter(input => input.value > 0)
            .map(input => ({
                elementId: input.dataset.elementId,
                elementName: input.dataset.elementName,
                quantity: parseInt(input.value)
            }))

        if (selectedElements.length === 0) {
            alert("Please enter quantities for elements before combining.")
            return
        }

        console.log("Selected Elements:", selectedElements) // Debugging line

        try {
            const response = await fetch('/experiments/combine', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
                },
                body: JSON.stringify({ elements: selectedElements })
            })
            const data = await response.json()
            this.resultTarget.innerHTML = data.result
        } catch (error) {
            console.error("There was an error processing the combination:", error)
            this.resultTarget.innerHTML = "There was an error processing the combination."
        }
    }

    clear() {
        this.elementListTarget.querySelectorAll('input[type="hidden"]').forEach(input => {
            input.remove()
        })
        this.dropzoneAreaTarget.innerHTML = '<p>Drop elements here to increment the counter</p>'
        this.resultTarget.innerHTML = ""
        this.toggleButtons()
        this.togglePlaceholder()
    }

    toggleButtons() {
        const hasInput = Array.from(this.elementListTarget.querySelectorAll('input[type="hidden"]'))
            .some(input => input.value > 0)

        this.combineButtonTarget.style.visibility = hasInput ? "visible" : "hidden"
        this.clearButtonTarget.style.visibility = hasInput ? "visible" : "hidden"
    }

    togglePlaceholder() {
        if (this.dropzoneAreaTarget.querySelector('.dropped-element')) {
            this.dropzoneAreaTarget.querySelector('p').style.display = 'none'
        } else {
            this.dropzoneAreaTarget.querySelector('p').style.display = 'block'
        }
    }
}
