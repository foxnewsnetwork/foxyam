class Foxfire.AccountIndexRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'account/footer', outlet: 'footer'
    @render 'account/headers/index', outlet: 'header'