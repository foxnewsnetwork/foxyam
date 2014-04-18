class Negotiations::EmailCompaniesController < FoxYam::BaseController
  expose(:interactor) { _interactor }
  def edit; end

  def update
    _link_up_company_negotiation_offer!
    _get_out_of_here!
  end

  private
  def _raw_interactor
    @interactor ||= Negotiations::EmailCompanies::Interactor.new _negotiation, _email
  end
  def _interactor
    _raw_interactor.tap { |i| i.defaults = _get_params }
  end
  def _get_params
    params.permit(*Negotiations::EmailCompanies::DefaultManager::Fields)
  end
  def _email
    @email ||= FoxYam::Email.find params[:id]
  end
  def _link_up_company_negotiation_offer!
    @result = _updative_interactor.company_negotiation_offer!
  end
  def _conversation
    _interactor.conversation
  end
  def _get_out_of_here!
    return redirect_to conversation_tags_path _conversation if @result.success?
    render :new
  end
  def _updative_interactor
    _interactor.tap { |i| i.attributes = _company_params }
  end
  def _company_params
    params.require(:email_companies).permit(*Negotiations::EmailCompanies::Interactor::Fields)
  end
  def _negotiation
    @negotiation ||= FoxYam::Negotiation.find params[:negotiation_id]
  end
end