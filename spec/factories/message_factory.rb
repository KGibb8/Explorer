FactoryGirl.define do

  factory :message, :class => Message do
    user { create(:laotzu) }
    body { "Hey Shaka" }
  end

end
