require 'spec_helper'

RSpec.describe Coordinate do

  let(:shaka) { create(:shaka) }

  let(:lat_lng_params) {
    { title: "Climbing Kilimanjaro",
      description: Faker::Lorem.paragraph,
      start_time: Time.now + 90.days,
      end_time: Time.now + 92.days,
      start_locations_attributes: {
        "0" => {
          latitude: 37.275805,
          longitude: -3.054268,
          start_location: true
        }
      },
      end_locations_attributes: {
        "0" => {
          longitude: -3.067468,
          latitude: 37.355456,
          end_location: true
        }
      }
    }
  }

  let(:lat_lng_expedition) { shaka.create_expedition(lat_lng_params) }

  context "creating an expedition" do
    it "builds a start coordinate with set latitude and longitude" do
      expect(lat_lng_expedition.start_location).to_not be_nil
      expect(lat_lng_expedition.start_location.latitude).to eq 37.275805
    end

    it "builds an end coordinate with set latitude and longitude" do
      expect(lat_lng_expedition.end_location).to_not be_nil
      expect(lat_lng_expedition.end_location.latitude).to eq 37.355456
    end

    it "builds two separate coordinates and assigns them appropriately" do
      expedition = lat_lng_expedition
      expect(expedition.start_location).to_not eq expedition.end_location
    end
  end

  let(:location_params) {
    { title: "Climbing Kilimanjaro",
      description: Faker::Lorem.paragraph,
      start_time: Time.now + 90.days,
      end_time: Time.now + 92.days,
      start_locations_attributes: {
        "0" => {
          location: "London"
        }
      },
      end_locations_attributes: {
        "0" => {
          location: "London"
        }
      }
    }
  }

  let(:location_expedition) { shaka.create_expedition(location_params) }

  # %%TODO%% This no longer passes!

  context "geocoding the latitude and longitude" do

    before do
      @expedition = location_expedition
      @expedition.reload
    end

    it "builds a start coordinate with set latitude and longitude" do
      binding.pry
      expect(@expedition.start_location).to_not be_nil
      expect(@expedition.start_location.location).to eq "London"
      expect(@expedition.start_location.latitude).to eq 51.5073509
      expect(@expedition.start_location.longitude).to eq -0.1277583
    end

    it "builds an end coordinate with set latitude and longitude" do
      expect(@expedition.end_location).to_not be_nil
      expect(@expedition.end_location.location).to eq "London"
      expect(@expedition.end_location.latitude).to eq 51.5073509
      expect(@expedition.end_location.longitude).to eq -0.1277583
    end
  end

end
