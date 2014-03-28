class NegotiationsController < ApplicationController
  expose(:presenter) { _show_presenter.query _query_params }
  def show; end

  private
  def _show_presenter
    Negotiations::ShowPresenter.new _negotiation
  end

  def _negotiation

  end

  def _query_params
    params.permit(:per, :page)
  end
end