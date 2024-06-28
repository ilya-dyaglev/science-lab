import LabController from "./controllers/lab_controller"
import ApplicationController from "./controllers/application_controller"

export function registerControllers(application) {
  application.register("lab", LabController)
  application.register("application", ApplicationController)
}
