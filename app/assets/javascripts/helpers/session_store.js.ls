Foxfire.SessionStore = new Ember.Object()
Foxfire.SessionStore.userLoggedIn = ->
  Foxfire.SessionStore.get("currentUser")?

Foxfire.SessionStore.selectedTags = Ember.ArrayProxy.create content: Ember.A([])