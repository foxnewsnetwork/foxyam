Foxfire.SessionStore = new Ember.Object()
Foxfire.SessionStore.userLoggedIn = ->
  Foxfire.SessionStore.get("currentUser")?