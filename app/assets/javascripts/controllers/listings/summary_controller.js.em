class Foxfire.ListingsSummaryController extends Ember.ObjectController
  listing: ~>
    @model

  id: ~>
    @model.id

  isPrivate: ~>
    false

  pictures: ~>
    @store.find 'picture', listing_id: @id, per_page: 1

  createdAtWords: ~>
    @model.created_at