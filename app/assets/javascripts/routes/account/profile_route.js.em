class Foxfire.AccountProfileRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'account/footers/profile', outlet: 'footer'
    @render 'account/headers/profile', outlet: 'header'
