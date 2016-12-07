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

      lost = {
        title: "Lost in the Himalayas",
        description: Faker::Lorem.paragraph,
        start_time: Time.now - 15.days,
        end_time: Time.now - 12.days,
        start_lng: -3.054268,
        start_lat: 37.275805,
        end_lng: -3.067468,
        end_lat: 37.355456
      }
      expedition = @laotzu.create_expedition(lost)
      expedition.invite(@shaka)
      expedition.invite(@tara)
      expedition.invite(@shakyamuni)
      @tara.accept_invite(expedition)
      @laotzu.accept_invite(expedition)
      @shakyamuni.accept_invite(expedition)
      expedition.set_as_complete

      kilimanjaro = {
        title: "Climbing Kilimanjaro",
        description: Faker::Lorem.paragraph,
        start_time: Time.now + 90.days,
        end_time: Time.now + 92.days,
        start_lng: -3.054268,
        start_lat: 37.275805,
        end_lng: -3.067468,
        end_lat: 37.355456
      }
      expedition = @shaka.create_expedition(kilimanjaro)
      expedition.invite(@laotzu)
      expedition.invite(@tara)
      @tara.accept_invite(expedition)
      @laotzu.accept_invite(expedition)

      kailash = {
        title: "Pilgrimage around Mount Kailash",
        description: Faker::Lorem.paragraph,
        start_time: Time.now + 101.days,
        end_time: Time.now + 110.days,
        start_lng: -3.054268,
        start_lat: 37.275805,
        end_lng: -3.067468,
        end_lat: 37.355456
      }
      expedition = @tara.create_expedition(kailash)
      expedition.invite(@laotzu)
      expedition.invite(@shakyamuni)
      @shakyamuni.accept_invite(expedition)
      @laotzu.accept_invite(expedition)

      himalayas = {
        title: "Hiking in the Himalayas",
        description: Faker::Lorem.paragraph,
        start_time: Time.now + 131.days,
        end_time: Time.now + 150.days,
        start_lng: -3.054268,
        start_lat: 37.275805,
        end_lng: -3.067468,
        end_lat: 37.355456
      }
      expedition = @tara.create_expedition(himalayas)
      expedition.invite(@shakyamuni)
      @shakyamuni.accept_invite(expedition)

      tiger_leaping = {
        title: "Tiger Leaping Gorge",
        description: Faker::Lorem.paragraph,
        start_time: Time.now + 15.days,
        end_time: Time.now + 20.days,
        start_lng: -3.054268,
        start_lat: 37.275805,
        end_lng: -3.067468,
        end_lat: 37.355456
      }
      expedition = @laotzu.create_expedition(tiger_leaping)
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
