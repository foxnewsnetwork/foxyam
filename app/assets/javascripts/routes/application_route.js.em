class Foxfire.ApplicationRoute extends Ember.Route 
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
    openUsermenuModal: ->
      @render 'modals/usermenu',
        into: 'application'
        outlet: 'modal'
      $("footer").hide()

    closeModal: ->
      @closeModal()
      
    willTransition: ->
      Foxfire.SessionStore.logHistory Foxfire.Params.currentPath()
      @closeModal()
    
    formSubmitted: ->
      @closeModal()