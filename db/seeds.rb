require 'faker'

module SeedData

  def self.extended(object)
    object.instance_exec do

      User.destroy_all

      @shaka = User.create(username: "shaka_zulu", email: "shaka@zulu.sa", password: "123456", password_confirmation: "123456")
      @laotzu = User.create(username: "lao_tzu", email: "lao@tzu.ch", password: "123456", password_confirmation: "123456")

      @shaka.profile.biography = Faker::Lorem.paragraph
      @laotzu.profile.biography = Faker::Lorem.paragraph

    end
  end
end

extend SeedData
