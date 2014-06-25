class Foxfire.FulfilmentIndexRoute extends Ember.Route 
  renderTemplate: ->
    @_super()
    @render 'fulfilment/footer', outlet: 'footer'
    @render 'fulfilment/headers/index', outlet: 'header'