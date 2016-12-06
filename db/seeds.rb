require 'faker'

module SeedData

  def self.extended(object)
    object.instance_exec do

      Journey.destroy_all
      Expedition.destroy_all
      User.destroy_all

      @shaka = User.create(username: "shaka_zulu", email: "shaka@zulu.sa", password: "123456", password_confirmation: "123456")
      @laotzu = User.create(username: "lao_tzu", email: "lao@tzu.ch", password: "123456", password_confirmation: "123456")
      @shakyamuni = User.create(username: "shakyamuni", email: "shakyamuni@enlightened.being", password: "123456", password_confirmation: "123456")
      @tara = User.create(username: "green_tara", email: "green_tara@bodhisattva.being", password: "123456", password_confirmation: "123456")

      @shaka.profile.biography = Faker::Lorem.paragraph
      @laotzu.profile.biography = Faker::Lorem.paragraph

      expedition = @shaka.create_expedition("Hiking Kilimanjaro", Faker::Lorem.paragraph, Time.now + 91.days, Time.now + 96.days)
      expedition.invite(@laotzu)
      expedition.invite(@tara)
      @tara.accept_invite(expedition)
      @laotzu.accept_invite(expedition)

      expedition = @tara.create_expedition("Pilgrimage around Mount Kailash", Faker::Lorem.paragraph, Time.now + 101.days, Time.now + 110.days)
      expedition.invite(@laotzu)
      expedition.invite(@shakyamuni)
      @shakyamuni.accept_invite(expedition)
      @laotzu.accept_invite(expedition)

      expedition = @tara.create_expedition("Hiking in the Himalayas", Faker::Lorem.paragraph, Time.now + 131.days, Time.now + 150.days)
      expedition.invite(@shakyamuni)
      @shakyamuni.accept_invite(expedition)

      expedition = @laotzu.create_expedition("Tiger Leaping Gorge", Faker::Lorem.paragraph, Time.now + 15.days, Time.now + 20.days)
      expedition.invite(@shaka)
      expedition.invite(@tara)
      expedition.invite(@shakyamuni)
      @tara.accept_invite(expedition)
      @laotzu.accept_invite(expedition)
      @shakyamuni.accept_invite(expedition)

    end
  end
end

extend SeedData
