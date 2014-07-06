class Foxfire.RegistrationsNewRoute extends Ember.Route with Foxfire.CurrentAccountMixin
  renderTemplate: ->
    @_super()
    @render 'registrations/header', outlet: 'header'
    @render 'registrations/footer', outlet: 'footer'
  
  model: ->
    account: @store.createRecord "account"
    previousUrl: @previousUrl()

  previousUrl: ->
    Foxfire.HistoryHelper.previousNonSessionUrl()

  successfulLogin: (account) ->
    Foxfire.SessionStore.set "currentUser", account
    @transitionTo @previousOrAccount()

  previousPath: ->
    Foxfire.StringTools.eat @previousUrl(), "#"

  previousOrAccount: ->
    @previousPath() || @currentAccountPath()

  currentAccountPath: ->
    "/account/" + @currentAccountId

  failedLogin: (account) ->
    throw "Not Implemented"

  actions:
    formSubmitted: (account)->
      account.save().then _.bind(@successfulLogin, @), _.bind(@failedLogin, @)