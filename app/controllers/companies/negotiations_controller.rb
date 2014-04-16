class Companies::NegotiationsController < ApplicationController
  expose(:presenter) { _index_presenter.paginate _pagination_params }
  def index; end

  private
  def _company
    FoxYam::Company.find_by_id params[:company_id]
  end

  def _index_presenter
    Companies::Negotiations::IndexPresenter.from_company _company
  end

  def _pagination_params
    params.permit(:per, :page)
  end
end