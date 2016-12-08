FactoryGirl.define do

  factory :start_coordinate, :class => Coordinate do
    longitude { 37.355456 }
    latitude  { -3.067279 }
    start_location { true }
  end

  factory :end_coordinate, :class => Coordinate do
    longitude { 37.355456 }
    latitude  { -3.067479 }
    end_location { true }
  end

end
