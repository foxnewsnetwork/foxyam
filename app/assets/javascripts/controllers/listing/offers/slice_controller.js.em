class Foxfire.ListingOffersSliceController extends Ember.ObjectController with Foxfire.CurrentAccountMixin
  +computed model
  offer: ->
    @get "model"

  +computed model.account
  currentAccountIsRelevant: ->
    @currentAccountIs @get "model.account"