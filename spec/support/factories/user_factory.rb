class Factories::User < Factories::Base
  class << self
    def count
      @count ||= 0
    end

    def count=(n)
      @count = n
    end

    def increment_count
      self.count += 1
    end
  end
  def attributes
    {
      email: Faker::Internet.email.prepend(self.class.increment_count.to_s),
      password: 'asdf123',
      password_confirmation: 'asdf123'
    }
  end
end