class Foxfire.StepShowController extends Ember.ObjectController
  queryParams: ['category']
  category: null

  +computed category
  categoryEmail: ->
    return "" if @category is "email"
    "email"

  +computed category
  categoryVoice: ->
    return "" if @category is "voice"
    "voice"

  +computed category
  categoryComm: ->
    return "" if @category is "comm"
    "comm"
  
  +computed step.order_numbers
  previousOrderNumber: ->
    parseInt(@get "step.order_number") - 1

  +computed previousOrderNumber, step.fulfilment.steps.@each
  previousStep: ->
    return unless @get("step.fulfilment.steps")
    @get("step.fulfilment.steps").findBy "order_number", @previousOrderNumber

  +computed nextOrderNumber, step.fulfilment.steps.@each
  nextStep: ->
    return unless @get("step.fulfilment.steps")
    @get("step.fulfilment.steps").findBy "order_number", @nextOrderNumber

  +computed step.order_number
  nextOrderNumber: ->
    1 + parseInt @get "step.order_number"

  +computed model
  step: -> @model

  +computed stepType
  isPaymentStep: ->
    @stepType is "payment"

  +computed stepType
  isUploadStep: ->
    @stepType is "upload"

  +computed step.step_name
  isReceiveMoney: ->
    @get("step.step_name") is "receives payment"

  +computed step.step_name
  isReceiveGoods: ->
    @get("step.step_name") is "receives goods"

  +computed step.step_name
  stepType: ->
    switch @get "step.step_name"
      when "funds escrow account"
        "payment"
      when "provides booking", "provides loading pictures", "provides weight ticket", "provides packing list"
        "upload"
      when "receives payment", "receives goods", "files quality discount"
        "form"
      else
        "error: " + @get("step.step_name")
