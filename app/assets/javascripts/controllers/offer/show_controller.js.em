class Foxfire.OfferShowController extends Ember.ObjectController with Foxfire.CurrentAccountMixin
  +computed model.conversations
  conversations: ->
    @get("model.conversations")
  
  +computed model.account
  currentPartyIsRelevant: ->
    @currentAccountIs @get("model.account") or @currentAccountIs @get("listing.account")

  +computed model.listing
  listing: ->
    @model.listing