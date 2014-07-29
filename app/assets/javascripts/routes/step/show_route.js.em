class Foxfire.StepShowRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'step/headers/show', outlet: 'header'
    @render 'step/footers/show', outlet: 'footer'