# == Schema Information
#
# Table name: email_inboxes
#
#  id             :integer          not null, primary key
#  negotiation_id :integer
#  email_address  :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class FoxYam::EmailInbox < ActiveRecord::Base
  has_many :emails,
    class_name: 'FoxYam::Email'

  has_many :claimed_emails,
    -> { claimed },
    class_name: 'FoxYam::Email'

  has_many :unclaimed_emails,
    -> { unclaimed } ,
    class_name: 'FoxYam::Email'

  belongs_to :account,
    class_name: 'FoxYam::EmailAccount',
    foreign_key: 'email_address',
    primary_key: 'email_address'

  belongs_to :negotiation,
    class_name: 'FoxYam::Negotiation'


  scope :unclaimed,
    -> { where("#{self.table_name}.negotiation_id is null") }

  scope :claimed,
    -> { where("#{self.table_name}.negotiation_id is not null") }

  def name
    return "negotiation-#{negotiation_id}" if claimed?
    'INBOX'
  end

  def email
    email_address
  end

  def count
    unclaimed_count
  end

  def unclaimed_count
    unclaimed_emails.count
  end

  def claimed?
    negotiation.present?
  end

end
