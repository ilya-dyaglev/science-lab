import { Application } from "@hotwired/stimulus"
import LabController from "./controllers/lab_controller"
import ApplicationController from "./controllers/application_controller"


// Start the Stimulus application
const application = Application.start()

// Register controllers
application.register("lab", LabController)
application.register("application", ApplicationController)
