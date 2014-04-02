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

class EmailInbox < ActiveRecord::Base

  has_many :emails

  has_many :unclaimed_emails,
    -> { unclaimed } ,
    class_name: 'Email'

  belongs_to :account,
    class_name: 'EmailAccount',
    foreign_key: 'email_address',
    primary_key: 'email_address'

  belongs_to :negotiation


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
