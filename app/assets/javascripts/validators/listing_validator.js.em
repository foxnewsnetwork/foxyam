class Foxfire.ListingValidator extends Ember.Object
  init: ->
    @validate 'material_name',
      presence: true

    @validate 'is_private',
      presence: true
      inclusion: [true, false]

    @validate 'asking_price',
      numericality: { greater_than: 0 }

    @validate 'price_unit',
      presence: true
      inclusion: ["pound", "kilogram", "container"]

    @validate 'incoterm',
      presence: true
      inclusion: ["EXW", "FCA", "FAS", "FOB", "CPT", "CFR", "CIF", "CIP", "DAT", "DAP", "DDP"]

    @validate 'location_name',
      presence: true

    @validate 'quantity',
      presence: true
      numericality: { greater_than: 0 }

    @validate 'quantity_unit',
      presence: true
      inclusion: ["pounds", "kilograms", "containers"]

    @validate 'packing_weight',
      numericality: { greater_than: 0 }      

    @validate 'transportor',
      inclusion: ["40ST", "40HC", "45ST", "45HC","20ST","20HC"]

    @validate 'time_interval',
      inclusion: ['one-time', 'per week', 'biweek', 'per month', 'per year']

  validate: (field, opts) ->
    _.map opts, (value, name) =>
      @addValidator @validatorInstance field, name, value
  validatorInstance: (field_to_validate, name_of_validator, comparison_tools) ->
    validator_class = @getValidator(name_of_validator)
    validator_class.create
      subject: @listing
      key: field_to_validate
      aux: comparison_tools
  addValidator: (validator) ->
    @validators = [] unless @validators
    @validators = _.union @validators, [validator]
  getValidator: (name) ->
    switch name
      when "presence" then Foxfire.PresenceValidator
      when "inclusion" then Foxfire.InclusionValidator
      when "numericality" then Foxfire.NumericalityValidator
      else throw "#{name} is not a known validator"
  runValidations: ->
    _.map @validators, (validator) =>
      @pushError validator.errors unless validator.isValid()
  isValid: ->
    @runValidations()
    Ember.isEmpty @errors
  pushError: (error) ->
    @errors = [] unless @errors
    @errors = _.union @errors, [error]