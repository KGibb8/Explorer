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

    context "confirming a friendship" do
      context "as the requester" do
        before do
          @friendship = tara.friendships.first
          @time = Time.local(2016, 11, 30, 14, 30, 0)
          Timecop.freeze(@time)
          buddha.accept_friend(tara)
          @friendship.reload
        end

        after do
          Timecop.return
        end

        it "stores the time when the friendship was confirmed" do
          expect(@friendship.accepted_at).to eq @time
        end

        it "changes the status from 'pending' to 'confirmed'" do
          expect(@friendship.status).to eq 'confirmed'
        end

        it "can see the new friend in their friends list" do
          expect(tara.friends).to include buddha
        end
      end

      context "as the requested" do
        before do
          @friendship = buddha.friendships.first
          @time = Time.local(2016, 11, 30, 14, 30, 0)
          Timecop.freeze(@time)
          buddha.accept_friend(tara)
          @friendship.reload
        end

        after do
          Timecop.return
        end

        it "stores the time when the friendship was confirmed" do
          expect(@friendship.accepted_at).to eq @time
        end

        it "changes the status from 'requested' to 'confirmed'" do
          expect(@friendship.status).to eq 'confirmed'
        end

        it "can see the new friend in their friends list" do
          expect(buddha.friends).to include tara
        end
      end
    end

    context "rejecting a friendship" do
      before do
        @friendship = buddha.friendships.first
        buddha.reject_friend(tara)
        @friendship.reload
      end

      it "changes the status from 'requested' to 'rejected'" do
        expect(@friendship.status).to eq 'rejected'
      end

      it "can see the non-friend in their rejected list" do
        expect(buddha.rejected_friends).to include tara
      end

      it "cannot see the friend in their requested list" do
        expect(buddha.friend_requests).to_not include tara
      end

      it "the friend in their friend requests list" do
        expect(tara.requested_friends).to_not include buddha
      end
    end
  end

  describe "finding a Friendship" do
    context "between two existing users" do

      before do
        tara.befriend buddha
        buddha.accept_friend(tara)
        @taras_friendship = tara.friendships.first
        @buddhas_friendship = buddha.friendships.first
      end

      it "returns friendships between users" do
        friendships = Friendship.between(tara, buddha)
        expect(friendships).to include @taras_friendship
        expect(friendships).to include @buddhas_friendship
      end

    end
  end

end
