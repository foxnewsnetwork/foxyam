class Foxfire.ApplicationController extends Ember.ObjectController
  +computed Foxfire.Session.currentUser
  currentAccount: ->
    Foxfire.Session.currentUser
  +computed Foxfire.Session.currentUser
  userLoggedIn: ->
    Foxfire.Session.userLoggedIn()