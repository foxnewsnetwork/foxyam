class Apiv1::Fulfilments::IndexController < Apiv1::Fulfilments::ShowController
  def index
    render json: { fulfilments: _fake_fulfilments, log_entries: _log_entries }
  end
  private
  def _fake_fulfilments
    1.upto(rand(13)).map { _fake_fulfilment }
  end
end