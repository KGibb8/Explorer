require 'spec_helper'

RSpec.describe ChatsController do

  let(:shaka) { create(:shaka) }
  let(:laotzu) { create(:laotzu) }

  let(:expedition) { 
    shaka.create_expedition(
      name: "climbing kilimanjaro",
      description: Faker::Lorem.paragraph,
      start_time: Time.now + 90.days,
      end_time: Time.now + 92.days,
    )
  }

  let(:attending) do
    expedition.invite(laotzu)
    laotzu.accept_invite(expedition)
  end

  let(:invited) do
    expedition.invite(laotzu)
  end

  let(:requested) do
    expedition.request(laotzu)
  end

  let(:rejected) do
    expedition.request(laotzu)
    expedition.reject_attendance(laotzu)
  end

  describe "index action for chats" do

    context "as a logged in user" do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in laotzu
      end

      context "who is permitted" do

        context "who is registered as attending" do
          before do
            attending
            @get_index = Proc.new { get :index, params: { expedition_id: expedition.id } }
          end

          it "should return a 200 status" do
            expect(response).to be_ok
          end

          it "assigns the @chats variable" do
            expect(@get_index).to change{ assigns :chats }
          end

        end

        context "who is registered as invited" do
          before do
            invited
            @get_index = Proc.new { get :index, params: { expedition_id: expedition.id } }
          end

          it "should return a 200 status" do
            expect(response).to be_ok
          end
        end

      end

      context "who is unpermitted" do

        context "who is registered as rejected" do
          before do
            rejected
            get :index, params: { expedition_id: expedition.id }
          end

          it "should return a 302 status" do
            expect(response.status).to eq 302
          end
        end

        context "who is registered as requested" do
          before do
            requested
            get :index, params: { expedition_id: expedition.id }
          end

          it "should return a 302 status" do
            expect(response.status).to eq 302
          end

        end

      end
    end

  end
end
