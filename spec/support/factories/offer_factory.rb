class Factories::Offer < Factories::Base
  attr_accessor :attributes
  attr_hash_accessor :negotiation, :company

  def initialize
    @negotiation = Factories::Negotiation.mock
    @company = Factories::Company.mock
  end

  def belongs_to(whatever)
    tap do |f|
      f.negotiation = whatever if whatever.is_a? FoxYam::Negotiation
      f.company = whatever if whatever.is_a? FoxYam::Company
    end
  end
end