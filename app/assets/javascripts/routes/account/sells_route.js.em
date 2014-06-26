class Foxfire.AccountSellsRoute extends Foxfire.AccountIndexRoute
  renderTemplate: ->
    @_super()
    @render 'account/headers/sells', outlet: 'header'