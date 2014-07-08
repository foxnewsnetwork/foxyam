class Foxfire.ContactShowController extends Ember.ObjectController
  +computed model
  contact: -> @get 'model'
  +computed contact.isPhone
  isPhone: -> 
    @get("contact.isPhone")
  +computed contact.isEmail
  isEmail: ->
    @get("contact.isEmail")
  +computed isPhone, isEmail
  notSupported: ->
    not (@isEmail or @isPhone)
  +computed contact.contact_type
  contactIcon: ->
    return "fa-phone" if @get("contact.contact_type") is "mobile"
    return "fa-phone" if @get("contact.contact_type") is "landline"
    return "fa-envelope-o" if @get("contact.contact_type") is "email"
    return "fa-skype" if @get("contact.contact_type") is "skype"
    return "fa-wechat" if @get("contact.contact_type") is "wechat"
    return "fa-truck" if @get("contact.contact_type") is "snailmail"