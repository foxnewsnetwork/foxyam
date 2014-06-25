class Foxfire.OfferCheckoutRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'offer/headers/checkout', outlet: 'header'