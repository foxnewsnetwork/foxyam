Foxfire.MaterialsTagsRoute = Ember.Route.extend do
  model: ->
    @store.find "tag"
  renderTemplate: ->
    @_super()
    @render 'materials/headers/tags', outlet: 'header'
    @render 'materials/footers/search', outlet: 'footer'