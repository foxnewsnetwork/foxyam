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

require 'spec_helper'

describe Company do
  pending "add some examples to (or delete) #{__FILE__}"
end
