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
    name: "Lost in the Himalayas",
    description: Faker::Lorem.paragraph,
    start_time: Time.now - 15.days,
    end_time: Time.now - 12.days,
    start_locations_attributes: {
      "0" => {
        latitude: 29.651641,
        longitude: 91.169008,
        start_location: true
      }
    },
    end_locations_attributes: {
      "0" => {
        latitude: 27.716704,
        longitude: 85.322191,
        end_location: true
      }
    }
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
    name: "Climbing Kilimanjaro",
    description: Faker::Lorem.paragraph,
    start_time: Time.now + 90.days,
    end_time: Time.now + 92.days,
    start_locations_attributes: {
      "0" => {
        longitude: 37.275805,
        latitude: -3.054268,
        start_location: true
      }
    },
    end_locations_attributes: {
      "0" => {
        longitude: 37.355456,
        latitude: -3.067468,
        end_location: true
      }
    }
  }
  expedition = @shaka.create_expedition(kilimanjaro)
  expedition.invite(@laotzu)
  expedition.invite(@tara)
  @tara.accept_invite(expedition)
  @laotzu.accept_invite(expedition)

  kailash = {
    name: "Pilgrimage around Mount Kailash",
    description: Faker::Lorem.paragraph,
    start_time: Time.now + 101.days,
    end_time: Time.now + 110.days,
    start_locations_attributes: {
      "0" => {
        latitude: 31.098544,
        longitude: 81.306217,
        start_location: true
      }
    },
    end_locations_attributes: {
      "0" => {
        latitude: 31.067220,
        longitude: 81.311939,
        end_location: true
      }
    }
  }
  expedition = @tara.create_expedition(kailash)
  expedition.invite(@laotzu)
  expedition.invite(@shakyamuni)
  @shakyamuni.accept_invite(expedition)
  @laotzu.accept_invite(expedition)

  himalayas = {
    name: "Hiking in the Himalayas",
    description: Faker::Lorem.paragraph,
    start_time: Time.now + 131.days,
    end_time: Time.now + 150.days,
    start_locations_attributes: {
      "0" => {
        latitude: 29.651641,
        longitude: 91.169008,
        start_location: true
      }
    },
    end_locations_attributes: {
      "0" => {
        latitude: 27.716704,
        longitude: 85.322191,
        end_location: true
      }
    }
  }
  expedition = @tara.create_expedition(himalayas)
  expedition.invite(@shakyamuni)
  @shakyamuni.accept_invite(expedition)

  tiger_leaping = {
    name: "Tiger Leaping Gorge",
    description: Faker::Lorem.paragraph,
    start_time: Time.now + 15.days,
    end_time: Time.now + 20.days,
    start_locations_attributes: {
      "0" => {
        latitude: 27.302643,
        longitude: 100.250901,
        start_location: true
      }
    },
    end_locations_attributes: {
      "0" => {
        latitude: 27.165486,
        longitude: 100.065314,
        end_location: true
      }
    }
  }
  @tiger_leaping = @laotzu.create_expedition(tiger_leaping)
  @tiger_leaping.invite(@shaka)
  @tiger_leaping.invite(@shakyamuni)
  @laotzu.accept_invite(@tiger_leaping)
  @shakyamuni.accept_invite(@tiger_leaping)

end

Given(/^sample requests have been made$/) do
  @tiger_leaping.request(@tara)
end

Given(/^sample friend requests have been created$/) do
  @shakyamuni.befriend(@tara)
end
    
Given(/^sample friendships have been confirmed$/) do
  @shakyamuni.befriend(@tara)
  @laotzu.befriend(@tara)
  @tara.accept_friend(@laotzu)
  @tara.accept_friend(@shakyamuni)
end
