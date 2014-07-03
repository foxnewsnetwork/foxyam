class Foxfire.ConversationIndexController extends Ember.ObjectController with Foxfire.CurrentAccountMixin
  +computed model
  conversation: -> @model

  +computed currentAccountId, model.account_id
  currentAccountIsSpeaker: ->
    @currentAccountIdIs @model.account_id

  +computed conversation.attachments
  attachments: -> @conversation.attachments