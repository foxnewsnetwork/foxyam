class Foxfire.HistoryHelper
  @currentUrl = ->
    Foxfire.Params.currentPath!

  @previousTransition = ->
    @previousTransitionGiven -> true

  @previousTransitionGiven = (predicate) ->
    _.first _.select @histories!, predicate

  @previousUrl = ->
    return "" unless @previousTransition!
    Foxfire.Router.router.generateFromIntent @previousTransition!.intent

  @previousNonSessionUrl = ->
    @previousUrlGiven @notSessionOrRegistration

  @previousUrlGiven = (predicate) ->
    _.first _.select @histories-as-urls!, predicate

  @notSessionOrRegistration = (url) ->
    /sessions/ isnt url and /registrations/ isnt url

  @attemptLastTransition = ->
    return unless Foxfire.SessionStore.lastTransition?
    Foxfire.SessionStore.lastTransition.retry()
    Foxfire.SessionStore.lastTransition = undefined
    true

  @logTransition = (transition) ->
    if 32 < @histories!.unshift(transition)
      @histories!.pop!

  _history-array = []
  @histories = -> _history-array

  @histories-as-urls = ->
    _.map @histories!, (transition) ->
      Foxfire.Router.router.generateFromIntent transition.intent

