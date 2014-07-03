class Foxfire.OfferShowController extends Ember.ObjectController with Foxfire.CurrentAccountMixin
  +computed model.conversations
  conversations: ->
    @get("model.conversations")
  
  +computed model.account_id, model.listing.account_id, currentAccountId
  currentPartyIsRelevant: ->
    isbuyer = @currentAccountIdIs @get("model.account_id") 
    isseller = @currentAccountIdIs @get("model.listing.account_id")
    isbuyer or isseller 