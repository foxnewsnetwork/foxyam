class Foxfire.ListingsIndexRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'listings.footer', outlet: 'footer'
  setupController: (controller) ->
    controller.set "model", @compositeModel()
  compositeModel: ->
    listings: @store.find("listing")
    materials: @store.find("material")