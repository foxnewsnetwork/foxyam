# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  company_id :integer
#  name       :string(255)
#  email      :string(255)
#  phone      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
  belongs_to :company
end
