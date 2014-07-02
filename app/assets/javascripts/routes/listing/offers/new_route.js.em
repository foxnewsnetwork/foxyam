class Foxfire.ListingOffersNewRoute extends Ember.Route with Foxfire.CurrentAccountMixin
  afterModel: (model, transition) ->
    if @currentAccountIs model
      @transitionTo "listing.show", model
  renderTemplate: ->
    @_super()
    @render 'listing/offers/headers/new', outlet: 'header'