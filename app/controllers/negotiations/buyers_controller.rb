class Negotiations::BuyersController < ApplicationController
  expose(:interactor) { _get_interactor }
  def new; end

  def create
    _affliate_buyer_with_negotiation!
    _dispatch_emails!
    _get_out_of_here!    
  end
  private
  def _affliate_buyer_with_negotiation!
    @result = _creative_interactor.buyer!
  end
  def _creative_interactor
    _interactor.tap do |i|
      i.attributes = _buyer_params
    end
  end
  def _dispatch_emails!
    @result ||= _interactor.dispatch_emails!
  end
  def _get_out_of_here!
    redirect_to negotiation_path _negotiation if @result.success?
    render :new if @result.failed?
  end
  def _buyer_params
    params.require(:buyers).permit(*Negotiations::Buyers::Interactor::Fields)
  end
  def _interactor
    @interactor ||= Negotiations::Buyers::Interactor.new _negotiation
  end

  def _get_interactor
    _interactor.tap do |i|
      i.options = _option_params
    end
  end

  def _option_params
    params.permit(*Negotiations::Buyers::Interactor::Options)
  end

  def _negotiation
    @negotiation ||= Negotiation.find params[:negotiation_id]
  end
end