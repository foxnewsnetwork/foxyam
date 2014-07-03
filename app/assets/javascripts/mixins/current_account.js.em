mixin Foxfire.CurrentAccountMixin
  +computed Foxfire.SessionStore.currentUser
  userLoggedIn: ->
    Foxfire.SessionStore.userLoggedIn()

  +computed Foxfire.SessionStore.currentUser
  currentAccount: ->
    Foxfire.SessionStore.get("currentUser")

  +computed currentAccount.id
  currentAccountId: ->
    @get("currentAccount.id")

  currentUser: ->
    @get("currentAccount")
  
  currentAccountIdIs: (acc_id) ->
    u = @userLoggedIn
    m = "#{@currentAccountId}" is "#{acc_id}"
    u and m
  
  currentAccountIs: (account) ->
    @currentAccountIdIs account.get "id"
