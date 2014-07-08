class Foxfire.OfferContactsSliceController extends Ember.ObjectController
  +computed model
  contact: -> @model

  +computed model.contact_type
  contactTypeIcon: ->
    return "fa-phone" if @get("model.isPhone")
    return "fa-envelope-o" if @get("model.isEmail")
    return "fa-skype" if @get("model.contact_type") is "skype"
    return "fa-wechat" if @get("model.contact_type") is "wechat"
    return "fa-building" if @get("model.contact_type") is "snailmail"
    "fa-bullhorn"

  +computed model.contact_detail
  contactDetails: -> @get "model.contact_detail"