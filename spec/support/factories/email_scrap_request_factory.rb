class Factories::EmailScrapRequest < Factories::Base
  class TestHelper 
    def store_unread_emails
      [:success]
    end
  end
  attr_accessor :attributes
  attr_hash_accessor :email_account

  def initialize
    self.email_account ||= Factories::EmailAccount.mock
  end

  def belongs_to(merchant)
    self.email_account = merchant
  end

  private
  def _creator
    Queues.const_get self.class.to_s.split("::").tail.join("::")
  end
end