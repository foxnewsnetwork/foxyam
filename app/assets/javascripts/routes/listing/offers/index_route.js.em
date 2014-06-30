class Foxfire.ListingOffersIndexRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'listing/footer', outlet: 'footer'
    @render 'listing/offers/headers/index', outlet: 'header'