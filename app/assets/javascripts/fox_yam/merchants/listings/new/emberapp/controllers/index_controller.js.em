class Foxfire.IndexController extends Ember.ObjectController
  materialCtrl: ~>
    @model.materialCtrl

  priceCtrl: ~>
    @model.priceCtrl

  quantityCtrl: ~>
    @model.quantityCtrl

  packingCtrl: ~>
    @model.packingCtrl

  previewCtrl: ~>
    @model

  listingInteractor: ~>
    @model.listingInteractor

  actions:
    formSubmitted: (params)->
      either = @get("listingMaker")(@listing)
      if either.isLeft()
        @validationErrors = either.error
      if either.isRight()
        console.log "save successful"

