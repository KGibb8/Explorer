require 'spec_helper'

RSpec.describe Expedition do

  let(:shaka) { create(:shaka) }
  let(:laotzu) { create(:laotzu) }
  let(:buddha) { create(:buddha) }
  let(:tara) { create(:tara) }

  let(:expedition) { shaka.create_expedition(Time.now + 90.days, Time.now + 92.days) }

  context "creating an Expedition" do

    context "as the creator" do
      it "has attending users" do
        expect(expedition.attending_users).to include shaka
      end

      it "does not have invited users" do
        expect(expedition.invited_users).to_not include shaka
      end
    end

  end

end
