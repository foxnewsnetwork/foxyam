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
#  last_mined_at        :datetime
#

class FoxYam::EmailAccount < ActiveRecord::Base
  class << self
    def global_trade_payment_account
      @gtps_account ||= preload.select { |acc| acc.merchant.name == 'Global Trade Payment Inc' }.first
    end

    def gmails
      @gmails ||= YAML.load File.read Rails.root.join 'config', 'gmail.yml'
    end

    def preload
      gmails.map do |gmail|
        merchant = FoxYam::Merchant.preload_by gmail['merchant_name']
        gmail['merchant'] = merchant
        gmail
      end.map do |gmail|
        find_or_create_by gmail.permit('merchant', 'email_address', 'unencrypted_password')
      end
    end
    
  end
  has_many :all_inboxes,
    class_name: 'FoxYam::EmailInbox',
    foreign_key: 'email_address',
    primary_key: 'email_address'
  # has_many inboxes
  has_many :inboxes,
    -> { claimed },
    class_name: 'FoxYam::EmailInbox',
    foreign_key: 'email_address',
    primary_key: 'email_address'

  has_one :inbox,
    -> { unclaimed },
    class_name: "FoxYam::EmailInbox",
    foreign_key: 'email_address',
    primary_key: 'email_address'

  belongs_to :merchant,
    class_name: 'FoxYam::Merchant'

  def email
    email_address
  end

  def inbox_with_default
    return inbox_without_default if inbox_without_default.present?
    inboxes.find_or_create_by negotiation_id: nil
  end
  alias_method_chain :inbox, :default

  def password
    unencrypted_password
  end
end
