class Foxfire.ListingsIndexRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'listings.footer', outlet: 'footer'
    @render 'listings.header', outlet: 'header'
  setupController: (controller) ->
    controller.set "model", @compositeModel()
  compositeModel: ->
    listings: @store.find("listing")
    materials: @store.find("material")