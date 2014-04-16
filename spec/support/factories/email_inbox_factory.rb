class Factories::EmailInbox < Factories::Base
  attr_accessor :email_account
  
  def belongs_to(thing)
    tap do |f|
      f.email_account = thing if thing.is_a? EmailAccount
    end
  end

  def initialize
    self.email_account = Factories::EmailAccount.mock
  end

  def attributes
    { account: email_account }
  end
end