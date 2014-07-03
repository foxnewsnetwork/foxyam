class Foxfire.HistoryHelper
  @previousUrl = ->
    @previousUrlGiven -> true

  @previousNonSessionUrl = ->
    @previousUrlGiven @notSessionOrRegistration

  @previousUrlGiven = (predicate) ->
    _.first _.select Foxfire.SessionStore.histories(), predicate

  @notSessionOrRegistration = (url) ->
    /sessions/ isnt url and /registrations/ isnt url

  @attemptLastTransition = ->
    return unless Foxfire.SessionStore.lastTransition?
    Foxfire.SessionStore.lastTransition.retry()
    Foxfire.SessionStore.lastTransition = undefined
    true