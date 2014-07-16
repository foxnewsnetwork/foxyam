class Foxfire.TagShowRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'tag/headers/show', outlet: 'header'
    @render 'tag/footers/show', outlet: 'footer'