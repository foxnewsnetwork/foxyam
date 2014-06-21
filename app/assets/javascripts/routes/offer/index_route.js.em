class Foxfire.OfferIndexRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'offer/footer', outlet: 'footer'