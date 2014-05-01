class ActiveModel::ErrorsHelper
  class << self
    def add(error1, error2)
      error1.clone.tap do |e|
        error2.to_hash.each do |key, value|
          e.add key, value
        end
      end
    end
  end
end