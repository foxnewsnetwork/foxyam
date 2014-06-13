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
    quantityCtrl: @controllerFor("quantity_input").set("model", @store.find "location")
    packingCtrl: @controllerFor("packing_input").set("model", @store.find "location")
    # picturesInteractor: Foxfire.PicturesInteractor.create(maker: _.bind(@pictureMaker, @))
    # listingInteractor: Foxfire.ListingInteractor.create(maker: _.bind(@listingMaker, @))
  pictureMaker: (file) ->
    @store.createRecord('picture', file: file)
  listingMaker: (params) ->
    @store.createRecord("listing", params)
