class Foxfire.OfferShowRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'offer/footers/show', outlet: 'footer'
    @render 'offer/headers/show', outlet: 'header'