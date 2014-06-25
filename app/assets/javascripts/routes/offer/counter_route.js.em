class Foxfire.OfferCounterRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'offer/footers/counter', outlet: 'footer'
    @render 'offer/headers/counter', outlet: 'header'