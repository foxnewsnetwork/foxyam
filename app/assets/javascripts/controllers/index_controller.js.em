class Foxfire.IndexController extends Ember.ObjectController with Foxfire.CurrentAccountMixin
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

  +computed model
  listings: ->
    return unless @model
    _.take @model.filter( -> true ), 6
