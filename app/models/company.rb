# == Schema Information
#
# Table name: companies
#
#  id           :integer          not null, primary key
#  company_name :string(255)
#  permalink    :string(255)      not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Company < ActiveRecord::Base
  has_many :offers
  has_many :conversations
  has_many :contacts
  has_many :negotiations,
    through: :offers

  class << self 
    def find_by_company_name(thing)
      find_by_permalink to_permalink thing
    end

    def to_permalink(thing)
      thing.to_s.downcase.to_url
    end
  end

  before_create :_create_permalink

  def name
    company_name
  end

  def primary_contact
    contacts.merchantable.first
  end
  
  private
  def _create_permalink
    self.permalink = self.class.to_permalink company_name
  end
end
