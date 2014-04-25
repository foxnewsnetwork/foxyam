# == Schema Information
#
# Table name: envelopes_origins
#
#  id                 :integer          not null, primary key
#  envelope_id        :integer
#  origin_type        :string(255)      default("from"), not null
#  email_address      :string(255)      not null
#  email_presentation :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class FoxYam::Envelopes::Origin < ActiveRecord::Base
  OriginTypes = [ :from, :cc, :bcc ].freeze
  self.table_name = 'envelopes_origins'
  belongs_to :envelope,
    class_name: 'FoxYam::Envelope'
  scope :from_type,
    -> { where "#{self.table_name}.origin_type = ?", 'from' }
  scope :cc_type,
    -> { where "#{self.table_name}.origin_type = ?", 'cc' }
  scope :bcc_type,
    -> { where "#{self.table_name}.origin_type = ?", 'bcc' }
end
