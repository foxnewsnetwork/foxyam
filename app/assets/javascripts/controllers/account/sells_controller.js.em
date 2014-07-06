class Foxfire.AccountSellsController extends Ember.ObjectController
  +computed model.listings.@each
  listings: ->
    @model.listings