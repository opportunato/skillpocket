require 'ffaker'

Rake::Task['db:reset'].invoke
FileUtils.rm_rf(Dir.glob(Rails.root.join "public/uploads/*"))

coordinates_list = [
  {
    latitude: 40.71427,
    longitude: -74.00597
  },
  {
    latitude: 32.7152778,
    longitude: -117.1563889
  },
  {
    latitude: 37.77493,
    longitude: -122.41942
  },
  {
    latitude: 47.60621,
    longitude: -122.33207
  },
  {
    latitude: 34.05223,
    longitude: -118.24368
  },
  {
    latitude: 37.33939,
    longitude: -121.89496
  }
]

50.times do

  coordinates = coordinates_list.sample

  photo = File.open(File.join(Rails.root, "app/assets/images/denis.png"))
  profile_banner = File.open(File.join(Rails.root, "app/assets/images/profile_stub.jpeg"))

  user = User.create full_name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
          job: Faker::Lorem.words(3).join(' '),
          latitude: coordinates[:latitude],
          longitude: coordinates[:longitude],
          approved: true,
          email: Faker::Internet.email,
          photo: photo,
          profile_banner: profile_banner,
          social_authority: rand(100),
          twitter_id: SecureRandom.hex(10),
          twitter_handle: Faker::Lorem.word

  skill = Skill.create title: Faker::Lorem.words(6).join(' '),
    price: rand(10) * 10,
    smartphone_os: "iOS",
    user_id: user.id,
    category: Skill::NEW_CATEGORIES.sample
end

