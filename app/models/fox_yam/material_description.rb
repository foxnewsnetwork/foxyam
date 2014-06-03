# == Schema Information
#
# Table name: fox_yam_material_descriptions
#
#  id          :integer          not null, primary key
#  permalink   :string(255)      not null
#  name        :string(255)      not null
#  description :text
#  count       :integer          default(0), not null
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#

class FoxYam::MaterialDescription < ActiveRecord::Base
  self.table_name = 'fox_yam_material_descriptions'
  acts_as_paranoid
  before_create :_create_permalink

  class << self
    def get_by_material(material)
      find_by_permalink permalink_from_string material.material
    end

    def permalink_from_string(string)
      string.downcase.to_url
    end
  end
  private
  def _create_permalink
    self.permalink ||= self.class.permalink_from_string name
  end
end
