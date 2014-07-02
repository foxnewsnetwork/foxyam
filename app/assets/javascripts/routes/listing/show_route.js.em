class Foxfire.ListingShowRoute extends Foxfire.ListingBaseRoute
  renderTemplate: ->
    @_super()
    @render 'listing/headers/index', outlet: 'header'