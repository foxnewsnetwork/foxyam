require 'spec_helper'

describe Apiv1::Materials::MaterialPresenter do
  let(:material) { Factories::Conversations::Material.mock }
  let(:presenter) { described_class.new material }
  context '#name' do
    subject { presenter.name }
    specify { should be_present }
    specify { should eq material.material }
  end
  context '#permalink' do
    subject { presenter.permalink }
    specify { should be_present }
  end
  context '#count' do
    subject { presenter.count }
    specify { should eq 1 }
  end
  context 'relationships' do
    subject { lambda { presenter.count } }
    specify { should change(FoxYam::MaterialDescription, :count).by 1 }
  end
end