// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import KanbanController from "./kanban_controller"
application.register("kanban", KanbanController)

import TurboModalController from "./turbo_modal_controller"
application.register("turbo-modal", TurboModalController)
