require 'spec_helper'

RSpec.describe Coordinate do

  let(:shaka) { create(:shaka) }

  let(:lat_lng_expedition) { 
    shaka.create_expedition(
      name: "Climbing Kilimanjaro",
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
          latitude: 37.355456,
          longitude: -3.067468,
          end_location: true
        }
      }
    )
  }

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

end
