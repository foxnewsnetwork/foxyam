class Foxfire.OfferAcceptRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'offer/headers/accept', outlet: 'header'