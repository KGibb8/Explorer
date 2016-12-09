require 'spec_helper'

RSpec.describe JourneysController, type: :controller do

  let(:shaka) { create(:shaka) }
  let(:laotzu) { create(:laotzu) }

  let(:expedition_params) { 
    { title: "Climbing Kilimanjaro",
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

  let(:request_journey_params) { { expedition_id: expedition.id, journey: { expedition_id: expedition.id } } }

  let(:approve_journey_params) { { expedition_id: expedition.id, journey: { expedition_id: expedition.id, user_id: laotzu.id } } }

  let(:inviting_journeys_params) { { expedition_id: expedition.id, journeys: { user_ids: [laotzu.id] } } }

  describe "requesting action for journey" do
    before do
      post :requesting, params: request_journey_params
    end

    it "returns a 302 status" do
      expect(response.status).to eq 302
    end
  end

  describe "approve action for journey" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in shaka
      expedition.request(laotzu)
      post :approve, params: approve_journey_params
    end

    it "should return a 302 status" do
      expect(response.status).to eq 302
    end
  end

  describe "inviting action for journey" do
    before do
      shaka.befriend(laotzu)
      laotzu.accept_friend(shaka)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in shaka
      post :inviting, params: inviting_journeys_params
    end

    it "should return a 302 status" do
      expect(response.status).to eq 302
    end

  end
end
