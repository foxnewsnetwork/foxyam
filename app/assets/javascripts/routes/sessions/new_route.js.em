class Foxfire.SessionsNewRoute extends Foxfire.ApplicationRoute
  model: (params) ->
    session: @session()
    previousUrl: @previousUrl()
  previousUrl: ->
    Foxfire.SessionStore.get("previousUrl")
  session: ->
    @store.createRecord 'session'
  renderTemplate: ->
    @_super()
    @render 'sessions/header', outlet: 'header'
    @render 'sessions/footer', outlet: 'footer'
  
  successfulLogin: (session) ->
    Foxfire.SessionStore.set "currentUser", session
    @redirectUserBack()

  redirectUserBack: ->
    @transitionTo @previousOrAccount()

  failedLogin: (session) ->
    throw "Not Implemented"

  previousPath: ->
    Foxfire.StringTools.eat @previousUrl(), "#"

  previousOrAccount: ->
    @previousPath() || @currentAccountPath()

  currentAccountPath: ->
    "/account/" + @currentUser().get("id")

  actions:
    formSubmitted: (session)->
      session.save().then _.bind(@successfulLogin, @), _.bind(@failedLogin, @)