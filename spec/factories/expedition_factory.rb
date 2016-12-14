FactoryGirl.define do

  factory :expedition, :class => Expedition do
    creator { create(:shaka) }
    name { "Climbing Kilimanjaro" }
    description { Faker::Lorem.paragraph }
    start_time { Time.now + 90.days }
    end_time { Time.now + 92.days }
  end

  factory :expedition_with_coords, :class => Expedition do
    creator { create(:shaka) }
    name { "Climbing Kilimanjaro" }
    description { Faker::Lorem.paragraph }
    start_time { Time.now + 90.days }
    end_time { Time.now + 92.days }
    start_locations { [create(:start_coordinate)] }
    end_locations { [create(:end_coordinate)] }
  end
end
