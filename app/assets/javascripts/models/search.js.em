a = DS.attr
class Foxfire.Search extends DS.Model
  listings: DS.hasMany "listing"
  accounts: DS.hasMany "account"

  