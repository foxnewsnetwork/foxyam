class Foxfire.PictureFactory
  @attributes = ->
    file: Foxfire.FileFaker.image!
  @promise = ->
    new Ember.RSVP.Promise (resolve) ~>
      <~ Ember.run
      resolve Foxfire.BaseFactory.store!.createRecord 'picture', @attributes!