class Foxfire.ListingOffersRoute extends Foxfire.ListingIndexRoute
  renderTemplate: ->
    @_super()
    @render 'listing/footer', outlet: 'footer'
    @render 'listing/headers/offers', outlet: 'header'