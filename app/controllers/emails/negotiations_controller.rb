class Emails::NegotiationsController < ApplicationController
  expose(:interactor) { _interactor }
  def new; end

  def create
    _create_negotiation!
    _get_out_of_here!
  end

  private
  def _create_negotiation!
    @result = _creative_interactor.negotiation!
  end

  def _get_out_of_here!
    return redirect_to _fresh_path if interactor.new?
    return redirect_to _existing_path if interactor.existing?
    render :new if @result.error?
  end

  def _negotiation
    @negotiation ||= _interactor.negotiation
  end

  def _conversation
    @conversation ||= _interactor.conversation
  end

  def _interactor
    @interactor ||= Emails::Negotiations::Interactor.new _email, current_merchant
  end

  def _email
    @email ||= Email.find params[:email_id]
  end

  def _creative_interactor
    _interactor.tap do |i|
      i.attributes = _negotiation_params
    end
  end 

  def _negotiation_params
    params.require(:negotiations).permit(:permalink)
  end

  def _fresh_path
    new_conversation_company_path _conversation
  end

  def _existing_path
    new_email_negotiation_exist_path _email, _negotiation
  end

end