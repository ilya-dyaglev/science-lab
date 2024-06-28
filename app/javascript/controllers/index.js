import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-loading"

// Start the Stimulus application
const application = Application.start()

// Load all controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.
const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))
