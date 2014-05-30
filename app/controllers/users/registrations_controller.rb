class Users::RegistrationsController < Devise::RegistrationsController
  expose(:interactor) { _interactor }
  def new; end

  def create
    _create_and_signin_user!
    _setup_flash!
    _get_out_of_here!
  end

  private
  def _setup_flash!
    return set_flash_message :success, :signed_up if _successful_signup?
    return set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if _sorta_successful_signup?
    return set_flash_message :error, :email_has_already_been_userd_or_mistyped_password
  end
  def _successful_signup?
    _sorta_successful_signup? && user_signed_in?
  end
  def _sorta_successful_signup?
    interactor.successful?
  end
  def _unsuccessful_signup?
    interactor.failed?
  end
  def _create_user!
    self.resource = _creative_interactor.user!
  end
  def _create_and_signin_user!
    _create_user!
    _consider_signin_user 
  end
  def _get_out_of_here!
    return redirect_to _back_path if _successful_signup?
    render :new
  end
  def _back_path
    return interactor.back_path if interactor.back_path.present?
    return user_path current_user if user_signed_in?
    return root_path
  end

  def _consider_signin_user
    sign_in resource_name, resource if _sorta_successful_signup?
  end

  def _creative_interactor
    interactor.tap do |i|
      i.attributes = _user_params
    end
  end

  def _user_params
    params.require(:registrations).permit(*Users::Registrations::Interactor::Fields)
  end

  def _interactor
    @interactor ||= Users::Registrations::Interactor.new
  end
end