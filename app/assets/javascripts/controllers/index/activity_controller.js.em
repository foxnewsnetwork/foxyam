class Foxfire.IndexActivityController extends Ember.ObjectController
  +computed model
  activity: -> @model

  +computed activity.activity_type
  activityType: ->
    @get "activity.activity_type"

  +computed activityType
  actionName: ->
    switch @activityType
      when "offer"
        "offer.show"
      when "counteroffer"
        "offer.show"
      when "fulfilment"
        "step.show"
      when "listing"
        "listing.show"
      else
        "index"

  +computed activity.action_id
  actionId: -> @get "activity.action_id"

  +computed activity.hasBeenSeen
  activityClass: ->
    class_core = "list-group-item"
    class_core += " inactive" if @activity.hasBeenSeen
    class_core

  +computed activity.related_pic
  activityPic: -> @get "activity.related_pic"

  +computed activity.relatedAccount.company
  actionCompany: -> @get "activity.relatedAccount.company"

  +computed activity.activity_type
  isListingType: ->
    "listing" is @get "activity_type"
  
  +computed activity.activity_type
  isOfferType: ->
    "offer" is @get "activity_type"
  
  +computed activity.activity_type
  isCounterType: ->
    "counteroffer" is @get "activity_type"
  
  +computed activity.activity_type
  isFulfilmentType: ->
    "fulfilment" is @get "activity_type"
  
  +computed activity.material_name
  materialName: -> @get "activity.material_name"
  
  +computed activity.price_number
  priceNumber: -> 
    n = @get "activity.price_number"
    return unless n
    n.toPrecision 4
  
  +computed activity.location_name
  locationName: -> @get "activity.location_name"
  
  +computed activity.incoterm_name
  incotermName: -> @get "activity.incoterm_name"
  
  +computed activity.fulfilment_action_name
  fulfilmentActionName: -> @get "activity.fulfilment_action_name"
  
  +computed activity.fulfilment_summary
  fulfilmentSummary: -> @get "activity.fulfilment_summary"

