class Foxfire.FulfilmentIndexStepController extends Ember.ObjectController
  +computed model
  step: -> @model

  +computed step.status
  statusClass: ->
    switch @get "step.status"
      when "completed"
        "fa-check"
      when "inprogress"
        "fa-gear fa-spin"
      when "failed"
        "fa-times"
      when "not_yet"
        "fa-circle-o-notch"
      else
        "fa-warning"

  +computed listCoreClass
  listGroupClass: ->
    Foxfire.debugLog "list-group-item #{@listCoreClass}"

  +computed step.status
  listCoreClass: ->
    switch @get "step.status"
      when "completed"
        "success"
      when "inprogress"
        "warning"
      when "failed"
        "danger"
      when "not_yet"
        "inactive"
      else
        "danger"

  +computed step.step_name, buyerName, sellerName
  companyName: ->
    switch @get "step.step_name"
      when "funds escrow account"
        @buyerName
      when "provides booking"
        @buyerName
      when "provides loading pictures"
        @sellerName
      when "provides weight ticket"
        @sellerName
      when "provides packing list"
        @sellerName
      when "receives payment"
        @sellerName
      when "receives goods"
        @buyerName
      when "files quality discount"
        @buyerName
      else
        "Uh-oh, error"

  +computed step.fulfilment.offer.account.company
  buyerName: ->
    @get "step.fulfilment.offer.account.company"

  +computed step.fulfilment.offer.listing.account.company
  sellerName: ->
    @get "step.fulfilment.offer.listing.account.company"