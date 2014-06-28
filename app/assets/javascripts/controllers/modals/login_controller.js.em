class Foxfire.ModalsLoginController extends Foxfire.ApplicationController
  actions:
    swap2Signup: ->
      $(".login-form").hide()
      $(".signup-form").show()
    swap2Login: ->
      $(".login-form").show()
      $(".signup-form").hide()
    formSubmitted: (data) ->
      Foxfire.Session.set "currentUser", @store.createRecord("account", company: 1, email: 2)
      true