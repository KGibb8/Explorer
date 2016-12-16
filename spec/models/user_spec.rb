require 'spec_helper'

RSpec.describe User do

  let(:shaka) { create(:shaka) }
  let(:laotzu) { create(:laotzu) }

  context "new user registration" do
    context "with OAuth Facebook" do
      before do
        info = OAuthInfo.new("monkeyman@squirrelmailnet", "monkeyman", "http://some-url.net")
        auth = OAuthCallback.new("facebook", "12345", info)
        @user = User.from_omniauth(auth)
      end

      it "should create a User" do
        expect(@user).to be_valid
        expect(@user.username).to eq "monkeyman"
      end

      it "should find a user if one doesn't exist" do
        info = OAuthInfo.new("monkeyman@squirrelmailnet", "monkeyman", "http://some-url.net")
        auth = OAuthCallback.new("facebook", "12345", info)
        user = User.from_omniauth(auth)
        expect(user).to eq @user
      end
    end

    context "entering valid details" do
      it "is valid with a username" do
        expect(shaka).to be_valid
        expect(shaka.username).to eq "shaka_zulu"
      end
    end

    context "entering invalid details" do
      it "is invalid without a username" do
        shaka.username = nil
        expect(shaka).to_not be_valid
      end
    end
  end

  context "creating a User" do
    context "generating a profile" do
      it "automatically generates a profile on user creation" do
        expect(shaka.profile).to be_valid
      end
    end
  end

  describe "Expeditions" do
    describe "creating an Expedition" do

      before do
        @time = Time.local(2016, 11, 30, 14, 30, 0)
        Timecop.freeze(@time)
        expedition_params = {
          name: "Climbing Kilimanjaro",
          description: Faker::Lorem.paragraph,
          start_time: @time,
          end_time: @time + 92.days,
        }
        @expedition = shaka.create_expedition(expedition_params)
      end

      after do
        Timecop.return
      end

      it "has a convenience method to create an expedition" do
        expect(shaka.expeditions).to include @expedition
      end

      context "as the creator" do
        it "should set the creating user as the expedition's creator" do
          expect(@expedition.creator).to eq shaka
        end

        it "should set the expeditions start and end time" do
          expect(@expedition.start_time).to eq @time
          expect(@expedition.end_time).to eq @time + 92.days
        end

        it "has attending expeditions" do
          expect(shaka.attending_expeditions).to include @expedition
        end

        it "does not have invited expeditions" do
          expect(shaka.invited_expeditions).to_not include @expedition
        end
      end
    end

  let(:expedition) { create(:expedition) }

    context "inviting another user to join" do
      before do
        expedition.invite(laotzu)
      end

      it "has expedition invites" do
        expect(laotzu.invited_expeditions).to include expedition
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
    end

    context "expiry of an expedition" do
      before do
        attending
        expedition.set_as_complete
      end

      it "has attended expeditions" do
        expect(laotzu.attended_expeditions).to include expedition
      end
    end
  end
end
