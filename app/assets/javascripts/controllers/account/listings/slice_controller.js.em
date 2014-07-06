class Foxfire.AccountListingsSliceController extends Ember.ObjectController
  +computed model
  listing: -> @model

  +computed hasBeenFinalized
  listingClass: ->
    "inactive" unless @hasBeenFinalized or @hasNewOffer

  +computed model.offers.@each
  latestOffers: ->
    return [] unless @listing.offers
    @listing.offers.filter( -> true ).sort (b,a) -> a.get("created_at") > b.get("created_at")

  +computed latestOffers.length
  offerCount: ->
    @latestOffers.length

  +computed latestOffers
  latestOfferPair: ->
    _.take @latestOffers, 2

  +computed latestOffers.@each
  moreThanTwoOffers: ->
    @latestOffers.length > 2

  +computed hasNewOffer, hasBeenFinalized
  notifyColor: ->
    return "color-flare" if @hasNewOffer
    return "color-sunflower" if @hasBeenFinalized
    return "color-death" 

  +computed hasNewOffer, hasBeenFinalized
  notifyIcon: ->
    return "fa-circle" if @hasNewOffer
    return "fa-cog fa-spin"  if @hasBeenFinalized
    return "fa-archive" 

  +computed latestOffers
  hasNewOffer: ->
    _.sample [true, false]

  +computed latestOffers
  hasBeenFinalized: ->
    _.sample [true, false]