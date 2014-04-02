# == Schema Information
#
# Table name: email_accounts
#
#  id                   :integer          not null, primary key
#  merchant_id          :integer
#  email_address        :string(255)
#  unencrypted_password :string(255)
#  deleted_at           :datetime
#  created_at           :datetime
#  updated_at           :datetime
#

class EmailAccount < ActiveRecord::Base
  class << self
    def preload
      find_or_create_by email_address: 'cheapcthulhu4u@gmail.com', unencrypted_password: 'attentionjewswwiiiscoming'
    end
  end
  # has_many inboxes
  has_many :inboxes,
    -> { claimed },
    class_name: 'EmailInbox',
    foreign_key: 'email_address',
    primary_key: 'email_address'

  has_one :inbox,
    -> { unclaimed },
    class_name: "EmailInbox",
    foreign_key: 'email_address',
    primary_key: 'email_address'

  def email
    email_address
  end

  def password
    unencrypted_password
  end
end
