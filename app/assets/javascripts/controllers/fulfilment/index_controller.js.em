class Foxfire.FulfilmentIndexController extends Ember.ObjectController
  +computed model
  fulfilment: -> @model

  +computed model.steps.@each
  steps: ->
    return [] unless @get("model.steps")
    @model.steps.sortBy "order_number"

  +computed model.steps.@each
  completedSteps: ->
    return [] unless @get("model.steps")
    @model.steps.filter (step) -> "not_yet" isnt step.get "status"

  +computed model.steps.@each
  futureSteps: ->
    return [] unless @get("model.steps")
    @model.steps.filter (step) -> "not_yet" is step.get "status"