class Factories::Envelope < Factories::Base
  attr_accessor :email, :gmail

  def initialize(gmail=nil)
    @email = Factories::Email.mock
    @gmail = gmail
  end

  def belongs_to(thing)
    tap do |f|
      f.email = thing if thing.is_a? FoxYam::Email
    end
  end

  def attributes
    return gmail_attributes if gmail.present?
    random_attributes
  end

  def gmail_attributes
    {
      subject: gmail.envelope.subject,
      email: email
    }
  end
  def random_attributes
    {
      subject: Faker::Lorem.sentence,
      email: email
    }
  end
end