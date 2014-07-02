class Foxfire.RegistrationsNewController extends Foxfire.ApplicationController
  +computed model.previousUrl
  previousUrl: ->
    @get 'model.previousUrl'

  +computed model.account
  account: ->
    @get "model.account"

  +computed previousUrl
  backPath: ->
    @get("previousUrl") || "#/"
