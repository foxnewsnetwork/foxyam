class Foxfire.IndexController extends Ember.ObjectController
  materialCtrl: ~>
    @model.materialCtrl

  priceCtrl: ~>
    @model.priceCtrl

  quantityCtrl: ~>
    @model.quantityCtrl

  packingCtrl: ~>
    @model.packingCtrl

  picturesCtrl: ~>
    @model.picturesCtrl

  +computed model
  previewCtrl: ->
    @model

  listingMaker: ~>
    @model.listingMaker

  actions:
    formSubmitted: (params)->
      either = @get("listingMaker")(params) 
      if either.isLeft()
        return @validationErrors = either.error
      if either.isRight()
        return either.payload.then (listing) ->
          console.log listing
      throw "You have a bug with #{either}"

