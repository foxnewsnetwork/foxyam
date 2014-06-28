class Foxfire.ApplicationRoute extends Ember.Route
  userLoggedIn: ->
    Foxfire.Session.userLoggedIn()
  renderTemplate: ->
    @_super()
    @render 'footer', 
      outlet: 'footer'
      into: 'application'
    @render 'header',
      outlet: 'header'
      into: 'application'
  closeModal: ->
    @disconnectOutlet
      parentView: "application"
      outlet: "modal"
    $("footer").show()
    
  actions:
    openLoginModal: ->
      @render 'modals/login',
        into: 'application'
        outlet: 'modal'
      $("footer").hide()

    closeModal: ->
      @closeModal()
      
    willTransition: ->
      @closeModal()
    
    formSubmitted: ->
      @closeModal()