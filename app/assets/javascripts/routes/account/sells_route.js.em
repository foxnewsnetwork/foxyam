class Foxfire.AccountSellsRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'account/footer', outlet: 'footer'
    @render 'account/headers/sells', outlet: 'header'