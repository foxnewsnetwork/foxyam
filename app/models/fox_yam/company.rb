# == Schema Information
#
# Table name: companies
#
#  id            :integer          not null, primary key
#  company_name  :string(255)
#  permalink     :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#  merchant_id   :integer
#  company_email :string(255)
#

class FoxYam::Company < ActiveRecord::Base
  has_many :offers,
    class_name: 'FoxYam::Offer'
  has_many :conversations,
    class_name: 'FoxYam::Conversation'
  has_many :contacts,
    class_name: 'FoxYam::Contact'
  has_many :negotiations,
    through: :offers,
    class_name: 'FoxYam::Negotiation'
  belongs_to :merchant,
    class_name: 'FoxYam::Merchant'

  class << self 
    def find_by_company_name(thing)
      find_by_permalink to_permalink thing
    end

    def to_permalink(thing, merchant=nil)
      [thing, merchant.try(:id)].map(&:to_s).join('--').downcase.to_url
    end
  end

  before_create :_create_permalink

  def name
    company_name
  end

  def negotiations_count
    negotiations.count
  end

  def primary_contact
    contacts.merchantable.first
  end

  def primary_email
    primary_contact.try(:email) || company_email
  end
  
  private
  def _create_permalink
    self.permalink = self.class.to_permalink company_name, merchant
  end
end
