# == Schema Information
#
# Table name: envelopes
#
#  id         :integer          not null, primary key
#  email_id   :integer
#  subject    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class FoxYam::Envelope < ActiveRecord::Base
  self.table_name = 'envelopes'
  belongs_to :email,
    class_name: 'FoxYam::Email'
  has_one :from_address,
    -> { from_type },
    class_name: 'FoxYam::Envelopes::Origin'
  def from_address_with_defaults
    return from_address_without_defaults if from_address_without_defaults.present?
    FoxYam::Envelopes::Origin.new envelope: self, origin_type: :from
  end
  alias_method_chain :from_address, :defaults
  has_many :cc_addresses,
    -> { cc_type },
    class_name: 'FoxYam::Envelopes::Origin'
  has_many :bcc_addresses,
    -> { bcc_type },
    class_name: 'FoxYam::Envelopes::Origin'
end
