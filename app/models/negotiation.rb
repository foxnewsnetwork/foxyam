# == Schema Information
#
# Table name: negotiations
#
#  id           :integer          not null, primary key
#  deleted_at   :datetime
#  dead_at      :datetime
#  finalized_at :datetime
#  completed_at :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Negotiation < ActiveRecord::Base
end
