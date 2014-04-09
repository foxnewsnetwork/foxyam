class Negotiations::BuyersController < ApplicationController
  expose(:interactor) { _get_interactor }
  def new; end

  def create
    
  end
  private
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