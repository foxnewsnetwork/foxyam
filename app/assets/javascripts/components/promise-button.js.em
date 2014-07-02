class Foxfire.PromiseButtonComponent extends Ember.Component
  tagName: "button"
  classNames: "promise-button"
  classNameBindings: ["buttonState"]
  +computed model.isSaving
  buttonState: ->
    if @get("model.isSaving")
      "loading"
    else
      "ready"

  +observer buttonState
  updateSpinner: ->
    if @get("buttonState") is "loading"
      @$(".promise-button-content").hide()
      @$(".promise-button-spinner").show()
    else
      @$(".promise-button-content").show()
      @$(".promise-button-spinner").hide()