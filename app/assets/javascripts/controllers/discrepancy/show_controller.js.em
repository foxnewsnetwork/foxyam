class Foxfire.DiscrepancyShowController extends Ember.ObjectController
  +computed model
  discrepancy: -> @model

  +computed discrepancy.complaintParty
  accusingAccount: -> @get "discrepancy.complaintParty"

  +computed accusingAccount.company
  accusingCompany: -> @get "accusingAccount.company"

  +computed discrepancy.accusedParty
  accusedAccount: -> @get "discrepancy.accusedParty"

  +computed accusedAccount.company
  accusedCompany: -> @get "accusedAccount.company"

  +computed discrepancy.fulfilment
  fulfilment: -> @get "discrepancy.fulfilment"