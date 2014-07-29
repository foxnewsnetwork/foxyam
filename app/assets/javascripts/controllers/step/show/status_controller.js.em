class Foxfire.StepShowStatusController extends Ember.ObjectController with Foxfire.CurrentAccountMixin
  +computed model
  step: -> @model

  +computed step.status_key
  alertClass: ->
    switch @get "step.status_key"
      when "completed"
        "alert-success"
      when "inprogress"
        "alert-warning"
      when "not_yet"
        "alert-info"
      else
        "alert-danger"

  +computed step.status_key
  iconClass: ->
    switch @get "step.status_key"
      when "completed"
        "fa-check"
      when "inprogress"
        "fa-spin fa-cog"
      when "not_yet"
        "fa-circle-o-notch"
      else
        "fa-warning"

  +computed step.status_key
  statusKey: ->
    switch @get "step.status_key"
      when "completed"
        "done"
      when "inprogress"
        "in progress"
      when "not_yet"
        "previous step not complete"
      else
        "something went wrong: #{@get 'step.status_key'}"    

  +computed step.actionAccount
  accountWhoShouldAccount: ->
    @get "step.actionAccount"

  +computed accountWhoShouldAccount.company
  actionCompanyName: ->
    @get "accountWhoShouldAccount.company"

  +computed inProgress, currentAccountShouldAct, actionCompanyName
  alertInfo: ->
    return "waiting for you to complete this step" if @inProgress and @currentAccountShouldAct
    return "waiting for #{@actionCompanyName}" if @inProgress
    return "this step belongs to you, but the previous step hasn't been completed yet" if @notYet and @currentAccountShouldAct
    return "this step belongs to #{@actionCompanyName}, but the previous step hasn't been completed yet" if @notYet
    return "finished!" if @get("step.status_key") is "completed"

  +computed step.status_key
  notYet: ->
    @get("step.status_key") is "not_yet"

  +computed step.status_key
  inProgress: ->
    @get("step.status_key") is "inprogress"

  +computed currentAccount, accountWhoShouldAccount
  currentAccountShouldAct: ->
    @currentAccountIs @accountWhoShouldAccount