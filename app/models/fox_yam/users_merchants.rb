# == Schema Information
#
# Table name: users_merchants
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  merchant_id :integer
#  clearance   :string(255)      default("employee"), not null
#  created_at  :datetime
#  updated_at  :datetime
#

class FoxYam::UsersMerchants < ActiveRecord::Base
  CleranceTypes = [:employee, :scrub].freeze
  belongs_to :user,
    class_name: 'FoxYam::User'
  belongs_to :merchant,
    class_name: 'FoxYam::Merchant'
end
