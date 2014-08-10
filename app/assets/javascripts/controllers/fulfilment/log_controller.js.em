class Foxfire.FulfilmentLogController extends Ember.ObjectController with Foxfire.CurrentAccountMixin
  +computed model
  fulfilment: -> @model

  +computed fulfilment.account
  merchantAccount: -> @get "fulfilment.account"

  +computed fulfilment.buyerAccount
  buyerAccount: -> @get "fulfilment.buyerAccount"

  +computed merchantAccount, buyerAccount, currentAccount
  currentAccountRelevant: ->
    @currentAccountIs @merchantAccount or @currentAccountIs @buyerAccount

  +computed fulfilment.log_entries.@each
  entries: -> 
    return unless @get "fulfilment.log_entries"
    @get("fulfilment.log_entries").sortBy "created_at"
