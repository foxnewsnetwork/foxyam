# == Schema Information
#
# Table name: merchants
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  permalink  :string(255)
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#

class FoxYam::Merchant < ActiveRecord::Base
  acts_as_paranoid
  has_many :email_accounts,
    class_name: 'FoxYam::EmailAccount'

  has_many :inboxes,
    through: :email_accounts,
    class_name: 'FoxYam::EmailInbox'

  has_many :negotiations,
    -> { completed },
    class_name: 'FoxYam::Negotiation'

  has_one :negotiation,
    -> { incomplete },
    class_name: 'FoxYam::Negotiation'

  has_many :all_negotiations,
    class_name: 'FoxYam::Negotiation'

  has_many :users_merchants,
    class_name: 'FoxYam::UsersMerchants'
  has_many :users,
    through: :users_merchants,
    class_name: 'FoxYam::User'

  has_one :company,
    -> { joins(:merchant).where "#{FoxYam::Merchant.table_name}.name = #{FoxYam::Company.table_name}.company_name" },
    class_name: 'FoxYam::Company'

  has_many :companies,
    -> { extending FoxYam::Merchants::CompanyRelationship },
    class_name: 'FoxYam::Company'

  has_many :contacts,
    through: :companies,
    class_name: 'FoxYam::Contact'
    
  before_create :_create_permalink
  
  class << self
    def find_by_permalink(str)
      where(permalink: to_permalink(str)).first
    end

    def preload_by(name)
      find_or_create_by name: name
    end

    def to_permalink(name)
      name.downcase.to_url
    end
  end

  def company_with_default
    company || companies.find_by_permalink_but_create_by_company_name!(name)
  end

  def negotiation_draft
    negotiation || negotiations.create
  end

  def hires(user)
    users_merchants.create(user: user) && self
  end

  def consider_hiring(user)
    users_merchants.create(user: user, clearance: 'scrub') && self
  end

  private
  def _create_permalink
    self.permalink ||= self.class.to_permalink name
  end
end
