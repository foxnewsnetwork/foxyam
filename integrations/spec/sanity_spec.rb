require 'integration_helper'

describe Integrations::Flows::Sanity do
  let(:user) { described_class.run }
  it 'should have no errors' do
    user.errors.should be_blank
  end
end