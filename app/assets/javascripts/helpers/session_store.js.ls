Foxfire.SessionStore = new Ember.Object()
Foxfire.SessionStore.userLoggedIn = ->
  Foxfire.SessionStore.get("currentUser")?

Foxfire.SessionStore.logHistory = (url) ->
  if 255 < Foxfire.SessionStore.histories!.unshift(url)
    Foxfire.SessionStore.histories!.pop!

Foxfire.SessionStore.histories = ->
  Foxfire.SessionStore.historyArray ||= []