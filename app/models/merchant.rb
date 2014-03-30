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
  has_many :negotiations
end
