require 'spec_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:shaka) { create(:shaka) }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in shaka
  end

  describe "show action for profile" do
    before do
      @get_show = Proc.new { get :show, params: { user_id: shaka.id } }
    end

    it "should return a 200 status" do
      expect(response).to be_ok
    end

    it "assigns the profile in question" do
      expect(@get_show).to change { assigns :profile }
    end
  end

  describe "update action for profile" do
    before do
      profile_picture = Rack::Test::UploadedFile.new(File.join(__dir__, "../assets", "shaka.jpg"))
      params = {
        profile: {
          first_name: "Shaka",
          last_name: "Zulu",
          biography: Faker::Lorem.paragraph,
          avatar: profile_picture
        },
        user_id: shaka.id
      }
      process :update, method: :patch, params: params
    end

    it "should update a Profile" do
      expect(Profile).to receive(:update)
    end

    it "should return a 200 status" do
      expect(response).to be_ok
    end

    it "should return a JSON response" do
      expect(response.content_type).to eq "application/json"
    end

  end

end
