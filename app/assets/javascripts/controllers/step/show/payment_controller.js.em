class Foxfire.StepShowPaymentController extends Ember.ObjectController with Foxfire.CurrentAccountMixin
  months: [1,2,3,4,5,6,7,8,9,10,11,12]
  years: [2014, 2015, 2016, 2017, 2018, 2019, 2020]
  +computed model
  step: -> @model
  
  +computed payingAccount.company
  payingCompany: ->
    @get "payingAccount.company"

  +computed receivingAccount.company
  receivingCompany: ->
    @get "receivingAccount.company"

  +computed step.account
  payingAccount: ->
    @get "step.account"

  +computed payingAccount, currentAccount
  currentAccountIsPaying: ->
    @currentAccountIs @payingAccount

  +computed step.fulfilment.offer.listing.account
  receivingAccount: ->
    @get "step.fulfilment.offer.listing.account"

  +computed receivingAccount, currentAccount
  currentAccountIsReceiving: ->
    @currentAccountIs @receivingAccount

  +computed step.fulfilment.money_amount
  paymentAmount: ->
    @get "step.fulfilment.money_amount"

  thatTogglingShit: (thing) ->
    $(".toggle-#{thing}").each (ind, el) ->
      el$ = $ el
      if el$.hasClass "hidden"
        el$.removeClass "hidden"
      else
        el$.addClass "hidden"
    
  actions:
    openCredit: ->
      @thatTogglingShit "credit"
    openCheck: ->
      @thatTogglingShit "check"
    openWire: ->
      @thatTogglingShit "wire"