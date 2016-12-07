require 'spec_helper'

RSpec.describe Coordinate do

  let(:shaka) { create(:shaka) }

  let(:lat_lng_params) {
    { title: "Climbing Kilimanjaro",
      description: Faker::Lorem.paragraph,
      start_time: Time.now + 90.days,
      end_time: Time.now + 92.days,
      start_location_attributes: {
        latitude: 37.275805,
        longitude: -3.054268
      },
      end_location_attributes: {
        longitude: -3.067468,
        latitude: 37.355456
      }
    }
  }

  let(:lat_lng_expedition) { shaka.create_expedition(lat_lng_params) }

  context "creating an expedition" do
    it "builds a start coordinate with set latitude and longitude" do
      expect(lat_lng_expedition.start_location).to_not be_nil
      expect(lat_lng_expedition.start_location.latitude).to eq 37.275805
      binding.pry
    end

    it "builds an end coordinate with set latitude and longitude" do
      expect(lat_lng_expedition.end_location).to_not be_nil
      expect(lat_lng_expedition.end_location.latitude).to eq 37.355456
    end
  end

  let(:location_params) {
    { title: "Climbing Kilimanjaro",
      description: Faker::Lorem.paragraph,
      start_time: Time.now + 90.days,
      end_time: Time.now + 92.days,
      start_location_attributes: {
        location: "London"
      },
      end_location_attributes: {
        location: "London"
      }
    }
  }

  let(:location_expedition) { shaka.create_expedition(location_params) }

  context "geocoding the latitude and longitude" do
    it "builds a start coordinate with set latitude and longitude" do
      expect(location_expedition.start_location).to_not be_nil
      expect(location_expedition.start_location.location).to eq "London"
      expect(location_expedition.start_location.latitude).to eq 51.5073509
      expect(location_expedition.start_location.longitude).to eq -0.1277583
    end

    it "builds an end coordinate with set latitude and longitude" do
      expect(location_expedition.end_location).to_not be_nil
      expect(location_expedition.end_location.location).to eq "London"
      expect(location_expedition.end_location.latitude).to eq 51.5073509
      expect(location_expedition.end_location.longitude).to eq -0.1277583
    end
  end

end
