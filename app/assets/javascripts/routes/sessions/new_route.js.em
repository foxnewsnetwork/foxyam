class Foxfire.SessionsNewRoute extends Ember.Route with Foxfire.CurrentAccountMixin
  model: (params) ->
    session: @session()
    previousUrl: @previousUrl()
    
  previousUrl: ->
    Foxfire.HistoryHelper.previousNonSessionUrl()

  session: ->
    @store.createRecord 'session'

  renderTemplate: ->
    @_super()
    @render 'sessions/header', outlet: 'header'
    @render 'sessions/footer', outlet: 'footer'
  
  successfulLogin: (session) ->
    Foxfire.SessionStore.set "currentUser", session
    unless Foxfire.HistoryHelper.attemptLastTransition()
      @transitionTo @previousOrAccount()

  failedLogin: (session) ->
    throw "Not Implemented"

  previousPath: ->
    Foxfire.StringTools.eat @previousUrl(), "#"

  previousOrAccount: ->
    @previousPath() || @currentAccountPath()

  currentAccountPath: ->
    "/account/" + @currentAccountId

  actions:
    formSubmitted: (session)->
      session.save().then _.bind(@successfulLogin, @), _.bind(@failedLogin, @)