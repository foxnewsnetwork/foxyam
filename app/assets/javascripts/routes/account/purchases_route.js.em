class Foxfire.AccountPurchasesRoute extends Foxfire.AccountIndexRoute
  renderTemplate: ->
    @_super()
    @render 'account/headers/purchases', outlet: 'header'