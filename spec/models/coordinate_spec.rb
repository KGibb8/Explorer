require 'spec_helper'

RSpec.describe Coordinate do

  let(:shaka) { create(:shaka) }

  let(:expedition_params) {
    { title: "Climbing Kilimanjaro",
      description: Faker::Lorem.paragraph,
      start_time: Time.now + 90.days,
      end_time: Time.now + 92.days,
      start_coordinate_attributes: {
        latitude: 37.275805,
        longitude: -3.054268
      },
      end_coordinate_attributes: {
        longitude: -3.067468,
        latitude: 37.355456
      }
    }
  }

  let(:expedition) { shaka.create_expedition(expedition_params) }

  context "creating an expedition" do
    it "builds a start coordinate" do
      expect(expedition.start_coordinate).to_not be_nil
      expect(expedition.start_coordinate.latitude).to eq 37.275805
    end

    it "builds an end coordinate" do
      expect(expedition.end_coordinate).to_not be_nil
      expect(expedition.end_coordinate.latitude).to eq 37.355456
    end
  end

end
