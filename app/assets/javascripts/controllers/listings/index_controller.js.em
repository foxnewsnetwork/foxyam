class Foxfire.ListingsIndexController extends Ember.ObjectController
  materials: ~>
    @model.materials

  listings: ~>
    @model.listings

  listingCount: ~>
    @model.listings.length