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

  context "creating an Expedition" do
    before do
      @time = Time.local(2016, 11, 30, 14, 30, 0)
      Timecop.freeze(@time)
      @expedition = shaka.create_expedition(@time, @time + 92.days)
    end

    after do
      Timecop.return
    end

    it "has a convenience method to create an expedition" do
      expect(shaka.expeditions).to include @expedition
    end

    it "should set the creating user as the expedition's creator" do
      expect(@expedition.creator).to eq shaka
    end

    it "should set the expeditions start and end time" do
      expect(@expedition.start_time).to eq @time
      expect(@expedition.end_time).to eq @time + 92.days
    end

  end
end
