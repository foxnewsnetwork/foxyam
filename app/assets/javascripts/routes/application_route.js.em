class Foxfire.ApplicationRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'footer', 
      outlet: 'footer'
      into: 'application'
    @render 'header',
      outlet: 'header'
      into: 'application'
  