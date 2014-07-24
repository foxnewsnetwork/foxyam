mixin Foxfire.SessionGoBackMixin
  previousNonSessionRelatedTransition: ->
    Foxfire.HistoryHelper.previousTransitionGiven (transition) ->
      url = Foxfire.HistoryHelper.transitionToUrl(transition)
      Foxfire.HistoryHelper.notSessionOrRegistration url

  goBack: ->
    @back2WhereWeCameFrom() or @back2LoggedInAccount() or @back2Index()

  back2WhereWeCameFrom: ->
    transition = @previousNonSessionRelatedTransition()
    if transition
      transition.retry()
      true

  back2LoggedInAccount: ->
    if @currentAccountId
      @transitionTo "account.index", @currentAccountId
      true

  back2Index: ->
    @transitionTo "index"