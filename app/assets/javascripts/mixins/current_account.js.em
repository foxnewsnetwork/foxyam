mixin Foxfire.CurrentAccountMixin
  +computed Foxfire.SessionStore.currentUser
  userLoggedIn: ->
    Foxfire.SessionStore.userLoggedIn()

  +computed Foxfire.SessionStore.currentUser
  currentAccount: ->
    Foxfire.SessionStore.get("currentUser")

  currentUser: ->
    @get("currentAccount")
    
  currentAccountIs: (account) ->
    return false unless @get("currentAccount") and account
    @get("currentAccount.id") is account.get("id")
