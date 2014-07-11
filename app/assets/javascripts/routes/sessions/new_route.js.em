class Foxfire.SessionsNewRoute extends Ember.Route with Foxfire.CurrentAccountMixin, Foxfire.SessionGoBackMixin
  model: -> @store.createRecord 'session'

  renderTemplate: ->
    @_super()
    @render 'sessions/header', outlet: 'header'
    @render 'sessions/footer', outlet: 'footer'
  
  successfulLogin: (session) ->
    Foxfire.SessionStore.set "currentUser", session
    @goBack()

  failedLogin: (session) ->
    throw "Not Implemented"

  actions:
    formSubmitted: (session)->
      session.save().then _.bind(@successfulLogin, @), _.bind(@failedLogin, @)
    goBack: ->
      @goBack()