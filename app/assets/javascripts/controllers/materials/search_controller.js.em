class Foxfire.MaterialsSearchController extends Ember.ObjectController
  +computed model
  bloodhound: -> @get("model")

  +computed bloodpact
  listings: ->
    DS.PromiseArray.create promise: @bloodpact

  +computed selectedMaterial, bloodhound
  bloodpact: ->
    new Ember.RSVP.Promise (resolve) =>
      return resolve [] unless @selectedMaterial
      @bloodhound.get @selectedMaterial, (bloodlistings) ->
        resolve _.pluck bloodlistings, "listing"
  