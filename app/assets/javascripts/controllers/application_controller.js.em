class Foxfire.ApplicationController extends Ember.ObjectController
  +computed Foxfire.SessionStore.currentUser
  currentAccount: ->
    Foxfire.SessionStore.currentUser
  +computed Foxfire.SessionStore.currentUser
  userLoggedIn: ->
    Foxfire.SessionStore.userLoggedIn()