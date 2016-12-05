require 'spec_helper'

RSpec.describe ProfilesController do
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

end
