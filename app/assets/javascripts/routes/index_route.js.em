class Foxfire.IndexRoute extends Ember.Route
  model: ->
    @store.find "listing", limit: 6
  renderTemplate: ->
    @render "index",
      outlet: "breakout",
      into: 'application'
    @render 'header',
      outlet: 'header'
      into: 'application'
    @render 'index/footer',
      outlet: 'footer'
      into: 'application'
  