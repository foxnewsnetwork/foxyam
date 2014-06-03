#= require jquery_typeahead
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require ./new/foxfire

$('.no-script').hide()
$('footer').hide()
window.Foxfire = Ember.Application.create()
