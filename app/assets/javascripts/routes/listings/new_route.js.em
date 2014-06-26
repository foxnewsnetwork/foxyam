class Foxfire.ListingsNewRoute extends Foxfire.ApplicationRoute
  renderTemplate: ->
    @_super()
    @render 'listings/headers/new', outlet: 'header'
    @render 'listings/footers/new', outlet: 'footer'
  model: (params) ->
    @store.createRecord "listing"
