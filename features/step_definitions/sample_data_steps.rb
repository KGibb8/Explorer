Given(/^sample users have been created$/) do
  Journey.destroy_all
  Expedition.destroy_all
  User.destroy_all

  @tara = create(:tara)
  @shakyamuni = create(:buddha)
  @shaka = create(:shaka)
  @laotzu = create(:laotzu)
end

Given(/^sample expeditions have been created$/) do
  lost = {
    title: "Lost in the Himalayas",
    description: Faker::Lorem.paragraph,
    start_time: Time.now - 15.days,
    end_time: Time.now - 12.days,
    start_lat: 29.651641,
    start_lng: 91.169008,
    end_lat: 27.716704,
    end_lng: 85.322191
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
    start_lng: 37.275805,
    start_lat: -3.054268,
    end_lng: 37.355456,
    end_lat: -3.067468,
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
    start_lat: 31.098544,
    start_lng: 81.306217,
    end_lat: 31.067220,
    end_lng: 81.311939
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
    start_lat: 29.651641,
    start_lng: 91.169008,
    end_lat: 27.716704,
    end_lng: 85.322191
  }
  expedition = @tara.create_expedition(himalayas)
  expedition.invite(@shakyamuni)
  @shakyamuni.accept_invite(expedition)

  tiger_leaping = {
    title: "Tiger Leaping Gorge",
    description: Faker::Lorem.paragraph,
    start_time: Time.now + 15.days,
    end_time: Time.now + 20.days,
    start_lat: 27.302643,
    start_lng: 100.250901,
    end_lat: 27.165486,
    end_lng: 100.065314
  }
  expedition = @laotzu.create_expedition(tiger_leaping)
  expedition.invite(@shaka)
  expedition.invite(@tara)
  expedition.invite(@shakyamuni)
  @tara.accept_invite(expedition)
  @laotzu.accept_invite(expedition)
  @shakyamuni.accept_invite(expedition)
end
