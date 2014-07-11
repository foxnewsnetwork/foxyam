class Foxfire.ListingOffersNewRoute extends Ember.Route with Foxfire.CurrentAccountMixin
  beforeModel: (transition) ->
    unless @userLoggedIn
      @transitionTo "sessions.new"
  afterModel: (model, transition) ->
    if @currentAccountIs model.account
      @transitionTo "listing.show", model
  renderTemplate: ->
    @_super()
    @render 'listing/footer', outlet: 'footer'
    @render 'listing/offers/headers/new', outlet: 'header'