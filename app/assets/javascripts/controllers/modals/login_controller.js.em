class Foxfire.ModalsLoginController extends Foxfire.ApplicationController
  requestSession: (data)->
    @store.createRecord "session_request", email: data.email, password: data.password
  requestAccount: (session)->
    @store.find "account", session.id
  actions:
    swap2Signup: ->
      $(".login-form").hide()
      $(".signup-form").show()
    swap2Login: ->
      $(".login-form").show()
      $(".signup-form").hide()
    formSubmitted: (data) ->
      


