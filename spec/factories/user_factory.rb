FactoryGirl.define do

  factory :shaka, :class => User do
    username { "shaka_zulu" }
    email { "shaka@zulu.sa" }
    password { Faker::Internet.password }
  end

end
