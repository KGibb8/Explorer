require 'spec_helper'

RSpec.describe CoordinatesController, type: :controller do

  let(:shaka) { create(:shaka) }

  let(:expedition) { 
    shaka.create_expedition(
      name: "climbing kilimanjaro",
      description: Faker::Lorem.paragraph,
      start_time: Time.now + 90.days,
      end_time: Time.now + 92.days,
    )
  }

  let(:coordinate) { create(:end_coordinate)  }

  describe "update action for coordinate" do
    before do
      patch :update, params: { expedition_id: expedition.id, id: coordinate.id, coordinate: { latitude: coordinate.latitude, longitude: coordinate.longitude } }
    end

    it "should return a 200" do
      expect(response).to be_ok
    end

    it "should render a JSON response" do
      expect(response.content_type).to eq "application/json"
      last_response = JSON.parse(response.body)
      expect(last_response["success"]).to be_truthy
    end

  end

end
