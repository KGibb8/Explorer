require 'spec_helper'

RSpec.describe Chat do

  let(:shaka) { create(:shaka) }
  let(:laotzu) { create(:laotzu) }
  let(:buddha) { create(:buddha) }
  let(:tara) { create(:tara) }

  let(:expedition) { create(:expedition) }

  let(:attending) {
    expedition.request(buddha)
    expedition.permit_attendance(buddha)
  }

  context "starting a chat" do
    context "with valid creation criteria" do
      before do
        attending
        @chat = expedition.chats.create(topic: "Smashing pumpkins", creator: buddha)
      end

      it "has a topic" do
        expect(@chat).to be_valid
      end
    end

    context "with invalid creation criteria" do
      it "is invalid if the creator is not a part of the expedition" do
        chat = expedition.chats.create(topic: "Smashing pumpkins", creator: buddha)
        expect(chat).to_not be_valid
      end

      it "is invalid without a creator" do
        attending
        chat = expedition.chats.create(topic: "Smashing pumpkins")
        expect(chat).to_not be_valid
      end

      it "is invalid with no topic" do
        attending
        chat = expedition.chats.create
        expect(chat).to_not be_valid
      end

    end
  end

end
