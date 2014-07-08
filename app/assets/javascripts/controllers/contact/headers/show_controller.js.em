class Foxfire.ContactHeadersShowController extends Ember.ObjectController
  +computed account.id
  backPath: ->
    Foxfire.HistoryHelper.previousNonSessionUrl() || "#/"