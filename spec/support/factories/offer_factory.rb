class Factories::Offer < Factories::Base
  attr_accessor :attributes
  attr_hash_accessor :negotiation, :company

  def initialize
    self.negotiation = Factories::Negotiation.mock
    self.company = negotiation.merchant.company_with_default
  end

  def belongs_to(whatever)
    tap do |f|
      f.negotiation = whatever if whatever.is_a? FoxYam::Negotiation
      f.company = whatever if whatever.is_a? FoxYam::Company
      f.company = whatever.company_with_default if whatever.is_a? FoxYam::Merchant
    end
  end
end