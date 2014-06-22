class Foxfire.OfferCounterRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'offer/counter_footer', outlet: 'footer'