# == Schema Information
#
# Table name: places
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  permalink  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class FoxYam::Place < ActiveRecord::Base
  class << self
    def find_by_permalink_or_create_by(string)
      find_by_permalink(string) || create(name: string)
    end

    def find_by_permalink(string)
      where(permalink: to_permalink(string)).first
    end

    def to_permalink(name)
      name.to_s.downcase.to_url
    end
  end

  before_create :_create_permalink

  private
  def _create_permalink
    self.permalink = self.class.to_permalink name
  end
end
