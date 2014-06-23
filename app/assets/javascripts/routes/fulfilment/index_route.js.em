class Foxfire.FulfilmentIndexRoute extends Ember.Route 
  renderTemplate: ->
    @_super()
    @render 'fulfilment/footer', outlet: 'footer'