// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
import KanbanController from "./kanban_controller"
import TurboModalController from "./turbo_modal_controller"

application.register("hello", HelloController)
application.register("kanban", KanbanController)
application.register("turbo-modal", TurboModalController)