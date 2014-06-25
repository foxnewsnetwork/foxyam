class Foxfire.FulfilmentLogRoute extends Foxfire.FulfilmentIndexRoute
  renderTemplate: ->
    @_super()
    @render 'fulfilment/headers/log', outlet: 'header'