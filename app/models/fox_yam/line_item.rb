# == Schema Information
#
# Table name: line_items
#
#  id               :integer          not null, primary key
#  offer_id         :integer
#  item_description :string(255)
#  weight           :integer
#  unit_price       :decimal(12, 5)
#  created_at       :datetime
#  updated_at       :datetime
#

class FoxYam::LineItem < ActiveRecord::Base
  belongs_to :offer,
    class_name: 'FoxYam::Offer'
end
