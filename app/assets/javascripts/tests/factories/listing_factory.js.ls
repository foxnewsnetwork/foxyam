class Foxfire.ListingFactory
  @attributes = ->
    material_name: "FROM-EMBER-TEST-" + Faker.Name.firstName!
    is_private: false
    asking_price: 0.35
    price_unit: "pound"
    incoterm: "FAS"
    location_name: Faker.Address.city!
    quantity: 4
    quantity_unit: "containers"
    packing_weight: 36000
    transportor: "40ST"
    time_interval: "one-time"
  @mock = ->
    Ember.Object.create @attributes!
  @promise = ->
    new Ember.RSVP.Promise (resolve) ~>
      <~ Ember.run
      resolve Foxfire.BaseFactory.store!.createRecord 'listing' @attributes!
  