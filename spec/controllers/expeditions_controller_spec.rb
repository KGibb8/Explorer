require 'spec_helper'

RSpec.describe ExpeditionsController, type: :controller do
  let(:shaka) { create(:shaka) }
  let(:laotzu) { create(:laotzu) }
  let(:buddha) { create(:buddha) }
  let(:tara) { create(:tara) }

  let(:expedition_params) {
    { name: "Climbing Kilimanjaro",
      description: Faker::Lorem.paragraph,
      start_time: Time.now + 90.days,
      end_time: Time.now + 92.days,
      start_locations_attributes: {
        "0" => {
          longitude: 37.275805,
          latitude: -3.054268,
          start_location: true
        }
      },
      end_locations_attributes: {
        "0" => {
          longitude: 37.355456,
          latitude: -3.067468,
          end_location: true
        }
      }
    }
  }

  let(:expedition) { shaka.create_expedition(expedition_params) }

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
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in shaka
      process :create, method: :post, params: { expedition: expedition_params }
    end

    it "should return a 302 status" do
      expect(response.status).to eq 302
    end
  end


  describe "show action for expedition" do
    before do
      @get_show = Proc.new { get :show, params: {id: expedition.id} }
    end

    it "should return a 200 status" do
      expect(response).to be_ok
    end

    it "should assign the relevant expedition" do
      expect(@get_show).to change{ assigns :expedition }
    end
  end

  describe "marker action for expedition" do
    before do
      get :markers, format: :json, params: { id: expedition.id }
    end

    it "should return a 200 status" do
      expect(response).to be_ok
    end

    it "should render a JSON response" do
      last_response = JSON.parse(response.body)
      markers = last_response["features"]
      start_coords = markers[0]["geometry"]["coordinates"]
      end_coords = markers[1]["geometry"]["coordinates"]
      start_lng = start_coords[0]
      start_lat = start_coords[1]
      end_lng = end_coords[0]
      end_lat = end_coords[1]
      expect(start_lat).to eq expedition.start_location.latitude
      expect(start_lng).to eq expedition.start_location.longitude
      expect(end_lat).to eq expedition.end_location.latitude
      expect(end_lng).to eq expedition.end_location.longitude
    end

  end

  let(:new_expedition_params) { 
    { name: "Walking Kilimanjaro",
      description: Faker::Lorem.paragraph,
      start_time: Time.now + 90.days,
      end_time: Time.now + 92.days,
      start_locations_attributes: {
        "0" => {
          longitude: 37.275805,
          latitude: -3.054268,
          start_location: true
        }
      },
      end_locations_attributes: {
        "0" => {
          longitude: 37.355456,
          latitude: -3.067468,
          end_location: true
        }
      }
    }
  }

  describe "update action for expedition" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in shaka
      process :update, method: :patch, params: { id: expedition.id, expedition: new_expedition_params }
    end

    it "should return a 200 status" do
      expect(response.status).to eq 200
    end

    it "should render a JSON response" do
      expect(response.content_type).to eq 'application/json'
      last_response = JSON.parse(response.body)
      expect(last_response["name"]).to eq "Walking Kilimanjaro"
    end

  end
end
