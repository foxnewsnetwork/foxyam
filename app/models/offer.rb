# == Schema Information
#
# Table name: offers
#
#  id             :integer          not null, primary key
#  offer_type     :string(255)      default("sell"), not null
#  company_id     :integer
#  negotiation_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Offer < ActiveRecord::Base
  belongs_to :negotiation
  belongs_to :company

  has_many :conversations
end
