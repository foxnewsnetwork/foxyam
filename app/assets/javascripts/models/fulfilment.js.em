a = DS.attr
class Foxfire.Fulfilment extends DS.Model
  account_id: a "number"
  status_icon: a "string"
  money_amount: a "number"
  transfer_type: a "string"
  transacted_goods: a "string"
  transaction_party: a "string"
  created_at: a "date"

  +computed created_at
  created_at_ago: -> $.timeago @created_at
  
  +computed account_id
  account: -> @store.find "account", @account_id

  +computed transfer_type
  directionality: ->
    if @transfer_type is "deposit" or @transfer_type is "sale"
      "inbound"
    else
      "outbound"
