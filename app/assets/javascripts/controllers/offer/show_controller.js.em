class Foxfire.OfferShowController extends Ember.ObjectController with Foxfire.CurrentAccountMixin
  +computed model.conversations
  conversations: ->
    @get("model.conversations")
  
  +computed model.account_id, model.listing.account_id, currentAccountId
  currentPartyIsRelevant: ->
    isbuyer = @currentAccountIdIs @get("model.account_id") 
    isseller = @currentAccountIdIs @get("model.listing.account_id")
    isbuyer or isseller 

  +computed contacts
  primaryContacts: ->
    return [] unless @contacts
    _.take @contacts.filter( -> true ), 2

  +computed model.account.contacts.@each
  contacts: ->
    @get("model.account.contacts")

  +computed contacts
  otherContactsAvailable: ->
    @get("contacts.length")
