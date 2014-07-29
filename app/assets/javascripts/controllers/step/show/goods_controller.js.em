class Foxfire.StepShowGoodsController extends Ember.ObjectController
  +computed model
  step: -> @model

  +computed step.account.company
  receivingCompany: -> @get "step.account.company"

  +computed step.fulfilment.transacted_goods
  goods: -> @get "step.fulfilment.transacted_goods"