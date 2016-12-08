FactoryGirl.define do

  factory :shaka, :class => User do
    username { "shaka_zulu" }
    email { "shaka@zulu.sa" }
    password { Faker::Internet.password }
  end

  factory :laotzu, :class => User do
    username { "lao_tzu" }
    email { "laotzu@dao.ch" }
    password { Faker::Internet.password }
  end

  factory :buddha, :class => User do
    username { "shakyamuni" }
    email { "shakyamuni@enlightened.being" }
    password { Faker::Internet.password }
  end

  factory :tara, :class => User do
    username { "green_tara" }
    email { "green_tara@enlightened.being" }
    password { Faker::Internet.password }
  end
end
