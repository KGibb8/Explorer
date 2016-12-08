require 'spec_helper'

RSpec.describe Friendship do

  let(:buddha) { create(:buddha) }
  let(:tara) { create(:tara) }

  describe "creating a Friendship" do
    before do
      tara.befriend buddha
    end

    context "requesting a friendship" do
      context "as the requester" do
        it "creates a friendship for the requesting user with status 'pending'" do
          expect(tara.requested_friends).to include buddha
          friendship = tara.friendships.first
          expect(friendship.status).to eq 'pending'
        end
      end

      context "as the requested" do
        it "creates a friendship for the requested user with status 'requested'" do
          expect(buddha.friend_requests).to include tara
          friendship = buddha.friendships.first
          expect(friendship.status).to eq 'requested'
        end
      end
    end
  end

end
