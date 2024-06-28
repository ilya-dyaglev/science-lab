import { Application } from "@hotwired/stimulus"
import LabController from "./lab_controller"
import ApplicationController from "./application_controller"

const application = Application.start()
application.register("lab", LabController)
application.register("application", ApplicationController)
