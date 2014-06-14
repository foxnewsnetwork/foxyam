class Foxfire.IndexRoute extends Ember.Route
  renderTemplate: ->
    @render 'fox_yam/merchants/listings/new/emberapp/index'
  setupController: (controller) ->
    controller.set 'model', @previewCtrl()
  previewCtrl: ->
    @controllerFor("preview_output").set "model", @modelHash()
  modelHash: ->
    materialCtrl: @controllerFor("material_input").set('model', @store.find 'material')
    priceCtrl: @controllerFor("price_input").set("model", @store.find 'location')
    quantityCtrl: @controllerFor("quantity_input").set("model", Ember.Object.create(filler: "cherryPie"))
    packingCtrl: @controllerFor("packing_input").set("model", Ember.Object.create(filler: "pinkiePie"))
    picturesCtrl: @controllerFor("pictures_input").set("model", Ember.Object.create(filler: "applePie"))
    listingMaker: _.bind(@listingMaker, @)
    # picturesInteractor: Foxfire.PicturesInteractor.create(maker: _.bind(@pictureMaker, @))
  pictureMaker: (file) ->
    @store.createRecord('picture', file: file)
  listingMaker: (params) ->
    @store.createRecord("listing", params).validate_and_save()
