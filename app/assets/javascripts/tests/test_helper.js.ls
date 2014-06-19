#= require_tree ./factories
#= require_tree ./helpers
#= require_tree ./models
#= require_tree ./validators
#= require_self

mocha.checkLeaks!
mocha.globals ['jQuery', '_', 'Ember', 'Foxfire']
Foxfire.setupForTesting!
Foxfire.injectTestHelpers!
mocha.run!