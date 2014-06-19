class Foxfire.ListingsNewController extends Ember.ObjectController
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

  listingMaker: (params)->
    @store.createRecord("listing", params).validate_and_save()
    
  appendPics: (params) ->
    params.pictures = @get("previewCtrl.pictures")
    params

  actions:
    formSubmitted: (params)->
      either = @listingMaker @appendPics params
      if either.isLeft()
        return @validationErrors = either.error
      if either.isRight()
        return either.payload.then (listing) ->
          console.log listing
      throw "You have a bug with #{either}"