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
  expedition = @laotzu.create_expedition("Lost in the Himalayas", Faker::Lorem.paragraph, Time.now - 15.days, Time.now - 12.days)
  expedition.invite(@shaka)
  expedition.invite(@tara)
  expedition.invite(@shakyamuni)
  @tara.accept_invite(expedition)
  @laotzu.accept_invite(expedition)
  @shakyamuni.accept_invite(expedition)
  expedition.complete

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
