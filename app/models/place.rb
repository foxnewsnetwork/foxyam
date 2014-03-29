# == Schema Information
#
# Table name: places
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  permalink  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Place < ActiveRecord::Base
end
