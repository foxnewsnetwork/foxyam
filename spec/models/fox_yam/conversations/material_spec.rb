# == Schema Information
#
# Table name: conversations_materials
#
#  id              :integer          not null, primary key
#  conversation_id :integer
#  material        :string(255)
#  notes           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  place_permalink :string(255)
#

require 'spec_helper'

describe FoxYam::Conversations::Material do
  let(:material) { described_class.create! material: 'dog food' }
  let(:place) { FoxYam::Place.create! name: 'Long Beach Port Harbour' }
  describe '#place' do
    before do
      material.update! place: place
    end
    it 'should have the material be located a the place' do
      material.place.should eq place
      material.place_permalink.should eq place.permalink
    end
  end
end
