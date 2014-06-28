Foxfire.Session = new Ember.Object()
Foxfire.Session.userLoggedIn = ->
  Foxfire.Session.get("currentUser")?