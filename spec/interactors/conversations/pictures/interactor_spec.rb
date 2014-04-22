require 'spec_helper'

describe Conversations::Pictures::Interactor do
  let(:conversation) { Factories::Conversation.mock }
  let(:raw_interactor) { described_class.new conversation }
  let(:interactor) { raw_interactor.tap { |i| i.attributes = @params } }
  let(:result) { interactor.picture_tag! }
  let(:attached_file) { FoxYam::AttachedFile.create! }
  before do
    @params = {
      description: Faker::Lorem.sentence,
      attached_file_id: attached_file.id
    }
  end
  describe '#picture_tag!' do
    it 'should create a relationship' do
      expect { result }.to change(FoxYam::AttachedFiles::AttachedFilesConversationsPictures, :count).by 1
    end
    it 'should create a picture tag' do
      expect { result }.to change(FoxYam::Conversations::Picture, :count).by 1
    end
    it 'should be successful' do
      result.should be_success
    end
  end
  context 'auxiliary relationships' do
    before { result }
    let(:picture) { conversation.pictures.last }
    let(:relationships) { picture.attached_file_relationships }
    let(:relationship) { relationships.first }
    it 'should have done very little' do
      r = picture.attached_file_relationships.create! attached_file: attached_file
      r.picture.should eq picture
      r.attached_file.should eq attached_file
    end
    it 'should have an interactor with the attached_file' do
      interactor.attached_file.should be_a FoxYam::AttachedFile
      interactor.attached_file.should be_persisted
    end
    it 'should be a proper picture tag' do
      picture.should be_a FoxYam::Conversations::Picture
      picture.should be_persisted
    end
    it 'should have the proper relationship' do
      relationships.should be_present
      relationships.count.should eq 1
    end
    it 'should have a relationship that referrs correctly backwards' do
      relationship.should be_a FoxYam::AttachedFiles::AttachedFilesConversationsPictures
      relationship.picture_id.should eq picture.id
      relationship.picture.should eq picture
      relationship.picture.should be_present
    end
    it 'should have a picture correctly tied to the attached file' do
      picture.attached_files.should be_present
      picture.attached_files.should_not be_empty
      picture.attached_files.should include attached_file
    end
  end
end