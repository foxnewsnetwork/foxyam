class Foxfire.ConversationIndexRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'conversation/footer', outlet: 'footer'