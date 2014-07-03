class Apiv1::Attachments::IndexController < Apiv1::BaseController
  def index
    render json: { attachments: _fake_attachments }
  end
  private
  def _fake_attachments
    1.upto(10).map { _fake_attachment }
  end 
  def _fake_attachment
    {
      id: rand(99),
      conversation_id: params[:conversation_id] || rand(99),
      source: _some_emoji
    }
  end
  def _some_emoji
    "emoji/" + rand(777).to_s + ".png"
  end
end