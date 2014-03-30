# == Schema Information
#
# Table name: companies
#
#  id           :integer          not null, primary key
#  company_name :string(255)
#  permalink    :string(255)      not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Company < ActiveRecord::Base
  has_many :offers
  has_many :conversations
end
