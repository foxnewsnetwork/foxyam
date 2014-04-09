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
#  role       :string(255)
#

class Contact < ActiveRecord::Base
  Roles = [
    :sales,
    :logistics,
    :accounting,
    :records,
    :overseer
  ]
  belongs_to :company

  validates :role,
    inclusion: { in: Roles }

  scope :overseers,
    -> { where "#{self.table_name}.role = ?", :overseer }

  scope :merchantable,
    -> { where "#{self.table_name}.role = ? OR #{self.table_name}.role = ?", :overseer, :sales }

  scope :noroles,
    -> { where "#{self.table_name}.role is null" }
  def google_style
    "#{name} (#{email})"
  end
end
