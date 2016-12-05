require 'spec_helper'

RSpec.describe User do

  let(:shaka) { create(:shaka) }

  context "new user registration" do
    context "entering valid details" do
      it "is valid with a username" do
        expect(shaka).to be_valid
        expect(shaka.username).to eq "shaka_zulu"
      end
    end

    context "entering invalid details" do
      it "is invalid without a username" do
        shaka.username = nil
        expect(shaka).to_not be_valid
      end
    end
  end

  context "creating a User" do
    context "generating a profile" do
      it "automatically generates a profile on user creation" do
        expect(shaka.profile).to be_valid
      end
    end
  end

end
