class Foxfire.RegistrationsNewRoute extends Ember.Route with Foxfire.CurrentAccountMixin, Foxfire.SessionGoBackMixin
  model: -> @store.createRecord "account"
  renderTemplate: ->
    @_super()
    @render 'registrations/header', outlet: 'header'
    @render 'registrations/footer', outlet: 'footer'
  

  previousUrl: ->
    Foxfire.HistoryHelper.previousNonSessionUrl()

  successfulLogin: (account) ->
    Foxfire.SessionStore.set "currentUser", account
    @goBack()

  failedLogin: (account) ->
    throw "Not Implemented"

  actions:
    formSubmitted: (account)->
      account.save().then _.bind(@successfulLogin, @), _.bind(@failedLogin, @)
    goBack: -> @goBack()