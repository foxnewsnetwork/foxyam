class Foxfire.HistoryHelper
  @currentUrl = ->
    Foxfire.Params.currentPath!

  @previousTransition = ->
    @previousTransitionGiven -> true

  @previousTransitionGiven = (predicate) ->
    _.first _.select @histories!, predicate

  @previousUrl = ->
    @transition-to-url @previousTransition!

  @attemptLastTransition = ->
    trans = @previousTransition!
    return unless trans?
    trans.retry!
    true

  @logTransition = (transition) ->
    Ember.assert "transition should be ok", transition? and transition.intent? and transition.intent.name?
    if 8 < @histories!.unshift(transition)
      @histories!.pop!

  _history-array = []
  @histories = -> _history-array

  @transition-to-url = (transition) ->
    return unless transition? and transition.intent? and transition.intent.name?
    Foxfire.Router.router.generateFromIntent transition.intent  
  
  @notSessionOrRegistration = (url) ->
    /session/ isnt url and /registration/ isnt url