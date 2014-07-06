class Foxfire.AccountPurchasesController extends Ember.ObjectController
  +computed model.offers.@each
  offers: ->
    return [] unless @model.offers
    @model.offers.filter(-> true)
