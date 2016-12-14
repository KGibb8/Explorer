FactoryGirl.define do

  factory :start_coordinate, :class => Coordinate do
    longitude { 37.275805 }
    latitude  { -3.054268 }
    start_location { true }
  end

  factory :end_coordinate, :class => Coordinate do
    latitude  { 37.355456 }
    longitude { -3.067468 }
    end_location { true }
  end

end
