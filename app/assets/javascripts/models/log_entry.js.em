a = DS.attr
class Foxfire.LogEntry extends DS.Model
  log_type: a "string"
  log_subject: a "string"
  statement: a "string"
  account_id: a "string"
  provider_name: a "string"
  created_at: a "date"

  +computed account_id
  account: -> @store.find "account", @get "account_id"