Foxfire.log = (thing) ->
  console.log thing
  thing

Foxfire.debugLog = (thing) ->
  window.debug = thing
  console.log thing
  thing