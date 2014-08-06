class Foxfire.IndexController extends Ember.ObjectController with Foxfire.CurrentAccountMixin
  queryParams: ['tab', 'q']
  tab: null
  q: null

  +computed currentAccount.activities
  activities: ->
    @get("currentAccount.activities")

  +computed
  prices: ->
    @store.find "price_statistic", 1

  +computed
  quantities: ->
    @store.find "quantity_statistic", 1

  catchPhrases: [
    "mobile platform for b2b merchants",
    "for traders by slave programmers",
    "one central mercantile exchange",
    "actually work from your phone",
    "trade without counterparty risk",
    "your tech edge in competition"
  ]
  +computed
  cyclicCatchPhrase: ->
    _.sample @catchPhrases

  +computed currentAccount.company
  currentCompany: ->
    @get("currentAccount.company") or "company"

  +computed model
  listings: ->
    return unless @model
    _.take @model.filter( -> true ), 6
  
  +computed tab
  showActivity: ->
    @tab is "activity"

  +computed tab
  tabClass: (dog) ->
    "active bold" if @tab is dog

  +computed tab
  showRecommendations: ->
    Ember.isBlank(@tab) or @tab is "rec"