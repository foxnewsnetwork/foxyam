require 'spec_helper'

describe Apiv1::PicturesController do
  let(:conversation) { Factories::Conversation.mock }
  let(:create) { post :create, format: :json, picture: @params }
  before do
    @params = {
      conversation_id: conversation.id,
      file: File.new(Rails.root.join("public", "gotes.jpg"))
    }
  end
  context '#create' do
    subject { lambda { create } }
    specify { should change(FoxYam::AttachedFile, :count).by 1 }
    specify { should change(FoxYam::Conversations::Picture, :count).by 1 }
  end
  context 'response' do
    before { create }
    let(:json) { JSON.parse(response.body) }
    subject { json["picture"] }
    specify { should have_key "id" }
    specify { should have_key "conversation_id" }
    specify { should have_key "source" }
    specify { json["id"].should be_present }
    specify { json["source"].should be_present }
  end
end
