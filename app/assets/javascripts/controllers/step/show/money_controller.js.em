class Foxfire.StepShowMoneyController extends Ember.ObjectController
  +computed model
  step: -> @model

  +computed step.account.company
  receivingCompany: ->
    @get "step.account.company"

  +computed step.fulfilment.money_amount
  moneyAmount: ->
    @get "step.fulfilment.money_amount"