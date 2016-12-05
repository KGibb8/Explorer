require 'spec_helper'

RSpec.describe Journey do

  let(:shaka) { create(:shaka) }
  let(:laotzu) { create(:laotzu) }
  let(:buddha) { create(:buddha) }
  let(:tara) { create(:tara) }

  let(:expedition) { shaka.create_expedition(Time.now + 90.days, Time.now + 92.days) }

  context "creating a Journey" do

    context "setting status upon creation" do

      before do
        @journey = expedition.journeys.first
      end

      it "sets the creating user's status to attending" do
        expect(@journey.status).to eq 'attending'
      end

      it "does not default the creating user's status to invited" do
        expect(@journey.status).to_not eq 'invited'
      end

    end

  end

end
