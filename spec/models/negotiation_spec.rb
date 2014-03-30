# == Schema Information
#
# Table name: negotiations
#
#  id           :integer          not null, primary key
#  merchant_id  :integer
#  deleted_at   :datetime
#  dead_at      :datetime
#  finalized_at :datetime
#  completed_at :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Negotiation do
  pending "add some examples to (or delete) #{__FILE__}"
end
