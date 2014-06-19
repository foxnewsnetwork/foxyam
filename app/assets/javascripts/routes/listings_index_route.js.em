class Foxfire.ListingsIndexRoute extends Ember.Route
  setupController: (controller) ->
    controller.set "model", @compositeModel()
  compositeModel: ->
    listings: @store.find("listing")
    materials: @store.find("material")