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

require 'spec_helper'

describe Offer do
  pending "add some examples to (or delete) #{__FILE__}"
end
