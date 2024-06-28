import { Application } from "@hotwired/stimulus"
import { registerControllers } from "./register_controllers"

// Start the Stimulus application
const application = Application.start()

// Register controllers
registerControllers(application)
