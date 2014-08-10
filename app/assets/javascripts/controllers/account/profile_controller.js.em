class Foxfire.AccountProfileController extends Ember.ObjectController
  +computed model
  account: -> @model

  +computed account.listings
  listings: -> @get("account.listings")

  +computed account.locations.@each
  locations: ->
    return unless @get("account.locations")
    _.first @get("account.locations").toArray(), 3

  +computed discrepancies.@each
  resolvedDiscrepancies: ->
    @get("discrepancies").filter (d) -> d.get("hasBeenResolved")

  +computed discrepancies.@each
  unresolvedDiscrepancies: ->
    @get("discrepancies").filter (d) -> not d.get("hasBeenResolved")

  +computed account.discrepancies
  discrepancies: -> @get("account.discrepancies")
