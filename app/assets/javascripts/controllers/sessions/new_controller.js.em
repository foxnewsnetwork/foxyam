class Foxfire.SessionsNewController extends Foxfire.ApplicationController
  +computed model.previousUrl
  previousUrl: ->
    @get 'model.previousUrl'

  +computed model.session
  session: ->
    @get "model.session"

  +computed previousUrl
  backPath: ->
    @get("previousUrl") || "#/"

  
    
