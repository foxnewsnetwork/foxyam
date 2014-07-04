class Foxfire.AccountIndexController extends Ember.ObjectController
  +computed model.fulfilments.@each
  inboundFulfilments: ->
    fs = @model.fulfilments.filter (fulfilment) ->
      fulfilment.get("directionality") is "inbound"
    fs.sort (a,b) -> a.get("created_at") > b.get("created_at")

  +computed model.fulfilments.@each
  outboundFulfilments: ->
    fs = @model.fulfilments.filter (fulfilment) ->
      fulfilment.get("directionality") is "outbound"
    fs.sort (b,a) -> a.get("created_at") > b.get("created_at")

  +computed inboundFulfilments.@each, outboundFulfilments.@each
  balance: ->
    @sumOver(@inboundFulfilments) - @sumOver(@outboundFulfilments)

  +computed balance
  balanceButtonClass: ->
    if @balance < 0
      "btn btn-danger btn-lg bold"
    else
      "btn btn-success btn-lg bold"

  +computed balance
  balancePresentation: ->
    if @balance < 0
      "(#{-@balance})"
    else
      @balance


  sumOver: (fulfilments) ->
    return 0 unless fulfilments
    dollars = _.map fulfilments, (f) -> parseFloat f.get("money_amount")
    _.reduce dollars, ( (a,b) -> a + b ), 0 