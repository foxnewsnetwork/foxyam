#= require jquery_typeahead
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require ./new/foxfire

$('.no-script').hide()
window.Foxfire = Ember.Application.create()
$(document).ready ->
  $('body').append $('footer').remove()
