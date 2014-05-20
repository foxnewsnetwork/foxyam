class Factories::Conversation < Factories::Base
  class << self
    def full_mock
      mock_tags mock
    end
    def mock_tags(c)
      ::Factories::Conversations::Material.belongs_to(c).mock
      ::Factories::Conversations::Packing.belongs_to(c).mock
      ::Factories::Conversations::Picture.belongs_to(c).mock
      ::Factories::Conversations::Quantity.belongs_to(c).mock
      ::Factories::Conversations::Price.belongs_to(c).mock
      c
    end
  end

  attr_accessor :attributes
  attr_hash_accessor :offer, :company

  def initialize
    self.offer = Factories::Offer.mock
    self.company = offer.company
  end

  def belongs_to(whatever)
    new.tap do |f|
      f.offer = whatever if whatever.is_a? FoxYam::Offer
      f.company = whatever if whatever.is_a? FoxYam::Company
    end
  end
end


