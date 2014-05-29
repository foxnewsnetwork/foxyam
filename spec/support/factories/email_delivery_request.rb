class Factories::EmailDeliveryRequest < Factories::Base
  class TestHelper; end
  def attributes
    {
      mail_to: Faker::Internet.email,
      mail_from: Faker::Internet.email,
      mail_cc_to: Faker::Internet.email,
      mail_bcc_to: Faker::Internet.email,
      mail_subject: Faker::Company.bs,
      mailer_class: 'Factories::EmailDeliveryRequest::TestHelper',
      mailer_method: 'four_years_at_berkeley'
    }
  end
  private
  def _creator
    Queues.const_get self.class.to_s.split("::").tail.join("::")
  end

end