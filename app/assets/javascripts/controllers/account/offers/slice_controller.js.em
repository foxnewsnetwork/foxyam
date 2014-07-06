class Foxfire.AccountOffersSliceController extends Ember.ObjectController with Foxfire.CurrentAccountMixin
  +computed model
  offer: -> @get("model")

  +computed offer.listing
  listing: -> @offer.listing

  +computed model.listing.pictures.@each
  pictures: ->
    @get("model.listing.pictures")

  +computed activationClass
  sliceClass: ->
    "list-group-item #{@activationClass} avatar-dialogue"

  +computed hasNewReply, waitingReply2YourCounterOffer
  activationClass: ->
    @hasNewReply or @waitingReply2YourCounterOffer

  +computed offer.unread_conversations.@each
  hasNewReply: ->
    @get("offer.unread_conversations.length") > 0

  +computed offer.unread_conversations.firstObject
  waitingReply2YourCounterOffer: ->
    @currentAccountIdIs @get("offer.unread_conversations.firstObject.account_id")

  +computed offer.fulfilment.isMidTransaction
  offerInEscrow: ->
    @get("offer.fulfilment.isMidTransaction")

  +computed offer.fulfilment.isComplete
  offerArchived: ->
    @get("offer.fulfilment.isComplete")

  +computed offerInEscrow, offerArchived, waitingReply2YourCounterOffer, hasNewReply
  offerHasTerribleErrors: ->
    not (@offerArchived or @offerInEscrow or @waitingReply2YourCounterOffer or @hasNewReply)