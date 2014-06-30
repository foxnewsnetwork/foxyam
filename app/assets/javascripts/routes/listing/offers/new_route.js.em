class Foxfire.ListingOffersNewRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'listing/footer', outlet: 'footer'
    @render 'listing/offers/headers/new', outlet: 'header'