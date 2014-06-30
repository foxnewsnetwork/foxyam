class Foxfire.ListingOffersIndexRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'listing/footer', outlet: 'footer'
    @render 'listing/headers/offers', outlet: 'header'