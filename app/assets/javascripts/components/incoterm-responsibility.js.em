class Foxfire.IncotermResponsibilityComponent extends Ember.Component
  classNames: ['incoterm-responsibility']
  Responsibilities: ["Export customs declaration", "Carriage to port of export", "Unloading of truck in port of export", "Loading on vessel in port of export", "Carriage (Sea/Air) to port of import", "Insurance", "Unloading in port of import", "Loading on truck in port of import", "Carriage to place of destination", "Import customs clearance", "Import taxes"] 
  Incoterms: 
    EXW: ["Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer"]
    FCA: ["Seller",  "Seller",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer"]
    FAS: ["Seller",  "Seller",  "Seller",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer"]
    FOB: ["Seller",  "Seller",  "Seller",  "Seller",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer"]
    CPT: ["Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer"]
    CFR: ["Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer"]
    CIF: ["Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer"]
    CIP: ["Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Buyer",  "Buyer",  "Buyer",  "Buyer",  "Buyer"]
    DAT: ["Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Buyer",  "Buyer",  "Buyer",  "Buyer"]
    DAP: ["Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Buyer",  "Buyer"]
    DDP: ["Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Seller",  "Seller"]

  +computed responsibilities
  bresp: ->
    @get('responsibilities').filter (res) ->
      res.owner is "Buyer"
    
  +computed bresp
  buyer_responsibilities: ->    
    return [{ task: "Nothing" }] if Ember.isEmpty @get 'bresp'
    @get 'bresp'

  +computed sresp
  seller_responsibilities: ->
    return [{ task: "Nothing" }] if Ember.isEmpty @get 'sresp'
    @get 'sresp'    

  +computed responsibilities
  sresp: ->
    @get('responsibilities').filter (res) ->
      res.owner is "Seller"

  +computed incoterm
  incoarray: ->
    return [] if Ember.isEmpty @Incoterms[@get("incoterm")]
    @Incoterms[@get("incoterm")]

  +computed incoarray
  responsibilities: ->
    return [] if Ember.isEmpty @get 'incoarray' 
    _.zip(@Responsibilities, @get('incoarray')).map (rs) ->
      task: rs[0]
      owner: rs[1]