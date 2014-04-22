class Factories::Conversation < Factories::Base
  attr_accessor :attributes
  attr_hash_accessor :offer, :company

  def initialize
    @offer = Factories::Offer.mock
    @company = Factories::Company.mock
  end

  def belongs_to(whatever)
    new.tap do |f|
      f.offer = whatever if whatever.is_a? FoxYam::Offer
      f.company = whatever if whatever.is_a? FoxYam::Company
    end
  end
end