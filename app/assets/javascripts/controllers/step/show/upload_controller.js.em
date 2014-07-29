class Foxfire.StepShowUploadController extends Ember.ObjectController
  +computed model
  step: -> @model
  
  +computed step.account.company  
  uploadingCompany: ->
    @get "step.account.company"

  +computed step.step_name
  stuffToBeUploaded: ->
    switch @get "step.step_name"
      when "provides booking"
        "booking confirmation"
      when "provides loading pictures"
        "loading pictures"
      when "provides weight ticket"
        "certified weight ticket"
      when "provides packing list"
        "packing list"
      else
        "no known documents for " + @get("step.step_name")

