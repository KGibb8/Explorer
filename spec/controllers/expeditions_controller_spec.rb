require 'spec_helper'

RSpec.describe ExpeditionsController, type: :controller do
  let(:shaka) { create(:shaka) }
  let(:laotzu) { create(:laotzu) }
  let(:buddha) { create(:buddha) }
  let(:tara) { create(:tara) }

  describe "index action for expeditions" do

    context "as a logged in user" do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in shaka
        @get_index = Proc.new { get :index }
      end

      it "should return a 200 status" do
        expect(response).to be_ok
      end

      it "should assign the relevant expeditions" do
        expect(@get_index).to change{ assigns :most_recent }
      end
    end

    context "as a lurker" do
      before do
        @get_index = Proc.new { get :index }
      end

      it "should return a 200 status" do
        expect(response).to be_ok
      end

      it "should assign the relevant expeditions" do
        expect(@get_index).to change{ assigns :most_recent }
      end
    end

  end

  describe "create action for expedition" do

    before do
      params = {}
      @post_create = Proc.new { post :create, params: params }
    end

  end
end
