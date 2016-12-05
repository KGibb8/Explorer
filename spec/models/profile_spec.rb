require 'spec_helper'

RSpec.describe Profile do
  let(:shaka) { create(:shaka) }
  let(:profile) { shaka.profile }

  before do
    profile.first_name = "Shaka"
    profile.last_name = "Zulu"
    profile.save
  end

  it "should have a full name" do
    expect(profile.full_name).to eq "Shaka Zulu"
  end


end
