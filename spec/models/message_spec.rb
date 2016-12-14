require 'spec_helper'

RSpec.describe Message do

  let(:shaka) { create(:shaka) }
  let(:laotzu) { create(:laotzu) }
  let(:buddha) { create(:buddha) }
  let(:tara) { create(:tara) }

  let(:expedition_params) { 
    { name: "Climbing Kilimanjaro",
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

  context "a user sends a message to a friend" do

    it "should be valid without a chat" do
      message = laotzu.messages.create
      expect(message).to be_valid
    end

  end

  context "a user sends a message in the chat room of an expedition" do

    before do
      @chat = expedition.chats.create
    end

    context "with valid sending criteria" do
      it "is valid if the sending user is invited to the chat's expedition" do
        expedition.invite(laotzu)
        message = laotzu.messages.create(chat: @chat)
        expect(message).to be_valid
      end

      it "is valid if the sending user is an attendee of the chat's expedition" do
        expedition.invite(laotzu)
        laotzu.accept_invite(expedition)
        message = laotzu.messages.create(chat: @chat)
        expect(message).to be_valid
      end

      it "is valid if the sending user attended the chat's expedition" do
        expedition.invite(laotzu)
        laotzu.accept_invite(expedition)
        expedition.set_as_complete
        message = laotzu.messages.create(chat: @chat)
        expect(message).to be_valid
      end
    end

    context "with invalid sending criteria" do
      it "is invalid if the sending user is uninvolved in the expedition" do
        message = laotzu.messages.create(chat: @chat)
        expect(message).to_not be_valid
      end

      it "is invalid if the sending user is still requesting to be involved in the expedition" do
        expedition.request(laotzu)
        message = laotzu.messages.create(chat: @chat)
        expect(message).to_not be_valid
      end

      it "is invalid if the sending user has been rejected from the expedition" do
        expedition.request(laotzu)
        expedition.reject_attendance(laotzu)
        message = laotzu.messages.create(chat: @chat)
        expect(message).to_not be_valid
      end
    end

  end

end
