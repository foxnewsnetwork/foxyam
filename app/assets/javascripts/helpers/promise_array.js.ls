class Foxfire.PromiseArray
  @create = ({promises}) ->
    new Foxfire.PromiseArray promises
  (@promises) ->
    @payloads = []
    @promise = new Ember.RSVP.Promise (resolve) ~>
      @register-payloads ~> resolve @payloads

  then: (action) ->
    @promise.then action

  register-payloads: (complete) ->
    _.map @promises, (promise) ~>
      promise.then (payload) ~>
        @payloads.push payload
        complete! if @is-complete!

  is-complete: ->
    @payloads.length is @promises.length

