class Foxfire.OfferCancelRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'offer/headers/cancel', outlet: 'header'