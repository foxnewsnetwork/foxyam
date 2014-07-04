class Foxfire.AccountFulfilmentsSliceController extends Ember.ObjectController
  +computed model
  fulfilment: -> @model

  +computed model.status_icon, directionality
  statusIconClass: ->
    if @get("model.status_icon") is "inprogress"
      return "fa-cog fa-spin"
    if @get("directionality") is "inbound"
      return "fa-plus"
    if @get("directionality") is "outbound"
      return "fa-minus"
    "fa-warning"

  +computed model.status_icon
  statusClass: ->
    if @get("model.status_icon") is "done"
      "inactive"
    else
      "warning"

  +computed statusClass
  sliceClass: ->
    "list-tree-node #{@statusClass} avatar-dialogue"

  +computed fulfilment.directionality
  directionality: ->
    @fulfilment.directionality

  +computed model.transfer_type
  isDeposit: ->
    @get("model.transfer_type") is "deposit"

  +computed model.transfer_type
  isSale: ->
    @get("model.transfer_type") is "sale"

  +computed model.transfer_type
  isPurchase: ->
    @get("model.transfer_type") is "purchase"

  +computed model.transfer_type
  isWithdrawal: ->
    @get("model.transfer_type") is "withdrawal"
