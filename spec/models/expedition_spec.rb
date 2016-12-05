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

  context "inviting another user to join" do
    before do
      expedition.invite(laotzu)
    end

    it "has expedition invites" do
      expect(laotzu.expedition_invites).to include expedition
    end

    it "has invited users" do
      expect(expedition.invited_users).to include laotzu
    end
  end

  let(:attending) do
    expedition.invite(laotzu)
    laotzu.accept_invite(expedition)
  end

  context "confirming attendance" do
    before do
      attending
    end

    it "has attending expeditions" do
      expect(laotzu.attending_expeditions).to include expedition
    end

    it "has attending users" do
      expect(expedition.attending_users).to include laotzu
    end
  end

  context "expiry of an expedition" do
    before do
      attending
      expedition.complete
    end

    it "has attended users" do
      expedition.reload
      expect(expedition.attended_users).to include laotzu
    end
  end

  context "checking a user's status for the specific expedition" do
    before do
      expedition.invite(tara)
      tara.accept_invite(expedition)
      expedition.invite(buddha)
    end

    it "returns true if invited" do
      expect(expedition.invited?(buddha)).to be_truthy
    end

    it "returns true if attending" do
      expect(expedition.attending?(tara)).to be_truthy
    end
  end
end
