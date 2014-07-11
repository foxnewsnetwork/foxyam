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

  slideCurtains: (direction, callback) ->
    container$ = $("main#ember-main")
    container$.addClass("slide-from-#{direction}-animation")
    container$.one "webkitAnimationEnd oanimationend msAnimationEnd animationend", ->
      callback()
      container$.removeClass("slide-from-#{direction}-animation")

  notAnimating: (transition) ->
    return true unless transition? and transition.intent? and transition.intent.name?
    previousUrl = Foxfire.HistoryHelper.previousUrl()
    targetUrl = Foxfire.Router.router.generateFromIntent(transition.intent)
    previousUrl is targetUrl
    
  manageSlideTransition: (transition) ->
    return if @notAnimating transition
    direction = Foxfire.Sitemap.directionFromOurCurrentRouteTo(transition.intent.name)
    return if !direction? or direction is "teleport"
    transition.abort()
    @slideCurtains direction, -> Ember.run -> transition.retry()

  actions:
    openUsermenuModal: ->
      @render 'modals/usermenu',
        into: 'application'
        outlet: 'modal'
      $("footer").hide()

    closeModal: ->
      @closeModal()
      
    willTransition: (transition) ->
      @manageSlideTransition transition
      Foxfire.HistoryHelper.logTransition transition
      @closeModal()
    
    formSubmitted: ->
      @closeModal()