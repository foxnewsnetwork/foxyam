expect = chai.expect

describe "Foxfire.PromiseArray", ->

  context 'sanity', ->
    specify "should even be there", ->
      expect(Foxfire.PromiseArray).to.be.ok

    specify "should have a create function", ->
      expect(Foxfire.PromiseArray).to.have.property("create")

  context 'usage', ->
    beforeEach ->
      @raw-promises = []
      @raw-promises.push new Ember.RSVP.Promise (resolve) ->
        setTimeout (-> resolve 1), 100
      @raw-promises.push new Ember.RSVP.Promise (resolve) ->
        setTimeout (-> resolve 2), 115
      @raw-promises.push new Ember.RSVP.Promise (resolve) ->
        setTimeout (-> resolve 3), 130
      @par = Foxfire.PromiseArray.create promises: @raw-promises

    specify "raw promises should be properly initialized", ->
      expect(@raw-promises).to.have.length(3)

    specify "it should at least have promises", ->
      expect(@par.promises).to.have.length 3

    specify "par should be promise like", ->
      expect(@par).to.have.property "then"

    specify "resolution should happen when everything is complete", (done) ->
      @par.then (results) ->
        expect(results).to.have.length(3)
        expect(results[0]).to.equal 1
        expect(results[1]).to.equal 2
        expect(results[2]).to.equal 3
        done!

    specify "chaining should work", (done) ->
      @par.then (results) ->
        results
      .then (results) ->
        expect(results).to.have.length(3)
        expect(results[0]).to.equal 1
        expect(results[1]).to.equal 2
        expect(results[2]).to.equal 3
        done!

    specify "chaining should modify stuff", (done) ->
      @par.then (results) ->
        _.reduce results, (+)
      .then (value) ->
        expect(value).to.be.ok
        expect(value).to.equal 6
        value * 6
      .then (thirtysix) ->
        expect(thirtysix).to.equal 36
        done! 