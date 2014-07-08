class Apiv1::Contacts::IndexController < Apiv1::BaseController
  def index
    render json: { contacts: _fake_contacts }
  end
  private
  def _fake_contacts
    1.upto(1 + rand(8)).map { _fake_contact }.sort { |b,a| a[:precedence] <=> b[:precedence] }
  end
  def _fake_contact
    @contact_type = nil
    {
      id: params[:id] || rand(999),
      account_id: params[:account_id] || rand(44),
      contact_type: _contact_type,
      contact_detail: _contact_detail,
      precedence: rand(99)
    }
  end
  def _contact_type
    @contact_type ||= ["mobile", "landline", "email", "skype", "wechat", "snailmail"].sample
  end
  def _contact_detail
    case _contact_type
    when "mobile", "landline"
      Faker::PhoneNumber.phone_number
    when "email"
      Faker::Internet.email
    when "skype", "wechat"
      Faker::Internet.user_name
    when "snailmail"
      Faker::Address.street_address
    else
      throw :no_such_contact_type
    end
  end
end