class Foxfire.ListingEditController extends Foxfire.ApplicationController
  id: ~>
    @model.id

  +computed model.account
  account: ->
    @get("model.account")

  +computed account, currentAccount
  currentMerchantIsOwner: ->
    @get("currentAccount")? and @get("currentAccount.id") is @get("account.id")