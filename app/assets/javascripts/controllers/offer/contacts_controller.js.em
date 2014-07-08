class Foxfire.OfferContactsController extends Ember.ObjectController with Foxfire.CurrentAccountMixin
  +computed offer.account
  offerMaker: ->
    @get("offer.account")

  +computed offer.listing.account
  listingOwner: ->
    @get("offer.listing.account")

  +computed model
  offer: -> @get("model")

  +computed currentAccount, offerMaker, listingOwner
  account: ->
    if @currentAccountIs @offerMaker
      @listingOwner
    else
      @offerMaker

  +computed account.contacts.@each
  contacts: ->
    @get("account.contacts")