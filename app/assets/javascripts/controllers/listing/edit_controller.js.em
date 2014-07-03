class Foxfire.ListingEditController extends Foxfire.ApplicationController
  id: ~>
    @model.id

  +computed model.account
  account: ->
    @get("model.account")

  +computed account.id, currentAccountId
  currentMerchantIsOwner: ->
    @currentAccountIdIs @get("account.id")
