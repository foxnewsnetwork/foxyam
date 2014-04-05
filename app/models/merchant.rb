# == Schema Information
#
# Table name: merchants
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  permalink  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Merchant < ActiveRecord::Base
  has_many :negotiations,
    -> { completed }

  has_one :negotiation,
    -> { incomplete }

  class << self
    def preload
      create name: "FoxYam Test Merchant", permalink: 'foxyam-test-merchant'
    end
  end

  def negotiation_draft
    negotiation || negotiations.create
  end
end
