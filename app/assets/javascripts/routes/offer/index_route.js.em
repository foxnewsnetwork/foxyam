class Foxfire.OfferIndexRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'offer/footers/index', outlet: 'footer'
    @render 'offer/headers/index', outlet: 'header'