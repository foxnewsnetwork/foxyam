class Factories::Email < Factories::Base
  attr_accessor :email_inbox, :gmail

  def belongs_to(thing)
    tap do |f|
      f.email_inbox = thing if thing.is_a? FoxYam::EmailInbox
    end
  end

  def initialize
    self.email_inbox = Factories::EmailInbox.mock
    self.gmail = Factories::Gmail.mock
  end

  def attributes    
    email_attributes.merge external_id: Faker::Lorem.sentence.to_url,
      inbox: email_inbox
  end

  def email_attributes
    FoxYam::Email.raw_hash_from_email gmail
  end

end