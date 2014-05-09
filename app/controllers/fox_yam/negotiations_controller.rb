class FoxYam::NegotiationsController < FoxYam::BaseController
  expose(:presenter) { _show_presenter.query _query_params }
  before_filter :_select_correct_users_unless_public
  def show
    render 'negotiations/show'
  end

  private
  def _correct_merchant
    _negotiation.merchant
  end
  def _select_correct_users_unless_public
    return if _negotiation.public?
    _reject_anonymous_users || _select_correct_users
  end
  def _show_presenter
    ::Negotiations::ShowPresenter.new _negotiation
  end

  def _negotiation
    @negotiation ||= ::FoxYam::Negotiation.find params[:id]
  end

  def _query_params
    params.permit(*::Negotiations::ShowPresenter::Fields)
  end
end