class Foxfire.AccountProfileController extends Ember.ObjectController
  +computed model
  account: -> @model

  +computed account.listings
  listings: -> @get("account.listings")

  +computed account.locations.@each
  locations: ->
    return unless @get("account.locations")
    _.first @get("account.locations").toArray(), 3