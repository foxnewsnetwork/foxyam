class Apiv1::Contacts::ShowController < Apiv1::Contacts::IndexController
  def show
    render json: { contact: _fake_contact }
  end
end