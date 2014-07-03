class Foxfire.OfferConversationsSliceController extends Ember.ObjectController with Foxfire.CurrentAccountMixin
  +computed model
  conversation: -> @model

  +computed currentAccountId, model.account.id
  currentAccountIsSpeaker: ->
    @currentAccountIdIs @model.account.id