require 'spec_helper'

describe FoxYam::Listings::Pictures::Interactor do
  let(:raw_interactor) { described_class.new conversation }
  let(:conversation) { Factories::Conversation.mock }
  let(:interactor) { raw_interactor.tap { |i| i.attributes = @params } }
  let(:result) { interactor.pictures! }
  before do
    @filename = Rails.root.join('public','gotes.jpg')
    @pictures = 1.upto(4).map { File.new @filename }
    @params = { pictures: @pictures }
  end
  describe '#pictures!' do
    it 'should create 4 attached files' do
      expect { result }.to change(FoxYam::AttachedFile, :count).by 4
    end
    it 'should 4 relationships' do
      expect { result }.to change(FoxYam::AttachedFiles::AttachedFilesConversationsPictures, :count).by 4 
    end
    it 'should create 1 picture tag' do
      expect { result }.to change(FoxYam::Conversations::Picture, :count).by 1
    end
  end
  context 'relationships' do
    before { result }
    specify { conversation.pictures.should be_present }
    specify { interactor.picture.should be_present }
    specify { interactor.picture.attached_files.count.should eq 4}
    specify { interactor.errors.should be_blank }
    
  end
end