class Foxfire.ListingsNewRoute extends Ember.Route
  setupController: (controller) ->
    controller.set 'model', @previewCtrl()
  previewCtrl: ->
    @controllerFor("preview_output").set "model", @modelHash()
  materialCtrl: ->
    @controllerFor("material_input").set('model', @store.find 'material')
  priceCtrl: ->
    @controllerFor("price_input").set("model", @store.find 'location')
  quantityCtrl: ->
    @controllerFor("quantity_input").set "model", Ember.Object.create(filler: "cherryPie")
  packingCtrl: ->
    @controllerFor("packing_input").set "model", Ember.Object.create(filler: "pinkiePie")
  picturesCtrl: ->
    @controllerFor("pictures_input").set "model", Ember.Object.create(filler: "pinkiePie")
  modelHash: ->
    materialCtrl: @materialCtrl()
    priceCtrl: @priceCtrl()
    quantityCtrl: @quantityCtrl()
    packingCtrl: @packingCtrl()
    picturesCtrl: @picturesCtrl()
