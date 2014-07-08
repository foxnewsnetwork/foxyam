a = DS.attr
class Foxfire.Contact extends DS.Model
  account_id: a "number"
  contact_type: a "string"
  contact_detail: a "string"

  +computed account_id
  account: -> @store.find "account", @account_id
  +computed contact_type  
  isPhone: ->
    _.contains ["mobile", "landline"], @contact_type
  +computed contact_type      
  isEmail: ->
    @contact_type is "email"
  +computed isPhone, isEmail  
  isMegaphone: ->
    not (@isPhone or @isEmail)