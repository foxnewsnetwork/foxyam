class Foxfire.FulfilmentNowRoute extends Foxfire.FulfilmentIndexRoute
  renderTemplate: ->
    @_super()
    @render 'fulfilment/headers/now', outlet: 'header'