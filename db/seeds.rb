# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require "faker"

UserCity.destroy_all
Message.destroy_all
Occupation.destroy_all
UserOccupation.destroy_all
UserInterest.destroy_all
User.destroy_all
Interest.destroy_all
CostOfLiving.destroy_all
CityDetail.destroy_all
City.destroy_all

Survey.destroy_all


Chatroom.destroy_all

Review.destroy_all




# --------interests-------
Interest.create!(
  title: 'Volunteering'
)
Interest.create!(
  title: 'Traveling'
)
Interest.create!(
  title: 'Art & Design'
)
Interest.create!(
  title: 'Music'
)
Interest.create!(
  title: 'Reading'
)
# San\ Fransisco Berlin Frankfurt Amsterdam Stockholm Paris Madrid
# --------cities--------------
cities = %w[Istanbul Berlin Frankfurt Amsterdam Stockholm Paris Madrid]

# Gets all cities
teleport_api_cities = open('https://api.teleport.org/api/urban_areas/').read
the_city = JSON.parse(teleport_api_cities)


# ------------ create cities ---------------
cities.each do |seed_city|
  # Iterate through each city and find the ones provided in cities#array

  the_city['_links']['ua:item'].each do |cityy|
    if cityy['name'] == seed_city
      puts "Creating #{cityy['name']}"

      city_score_url = cityy['href'] # get the url for the city
      puts city_score_url
      get_general = open(city_score_url).read
      the_city_general = JSON.parse(get_general)


      @title = the_city_general['name']
      @country = the_city_general['_links']['ua:countries'][0]['name']

      # get scores url inside the general city url from the_city_general
      score_url = the_city_general['_links']['ua:scores']['href']
      score_without_details = open(score_url).read
      city_score = JSON.parse(score_without_details)

      @description = city_score['summary']
      @quality_of_life = (city_score['categories'][1]['score_out_of_10']).to_s

      # get scores url with more details from the_city_general
      get_detailed_score_url = the_city_general['_links']['ua:details']['href']
      score_details = open(get_detailed_score_url).read
      city_score_detailed = JSON.parse(score_details)


      # get country details url
      get_country_url = the_city_general['_links']['ua:identifying-city']['href']
      country_details = open(get_country_url).read
      city_detailed = JSON.parse(country_details)

      @latitude = city_detailed['location']['latlon']['latitude']
      @longitude = city_detailed['location']['latlon']['longitude']

      # get country currency url
      country_currency_url = city_detailed['_links']['city:country']['href']
      country_currency = open(country_currency_url).read
      currency_of = JSON.parse(country_currency)
      @currency = currency_of['currency_code']

      # puts city_score_url
      # puts score_url
      # puts get_detailed_score_url

      City.create!(
        title: @title,
        description: @description,
        country: @country,
        latitude: @latitude,
        longitude: @longitude,
        quality_of_life: @quality_of_life,
        income: 233,
        living_cost: 3432,
        traffic: 'werew',
        population: 80000000,
        currency: @currency,
        weather: 'sunny',
        score: 3
      )
      puts City.last

      # salaries
      salary_url = the_city_general['_links']['ua:salaries']['href']
      salary_general = open(salary_url).read
      salaries = JSON.parse(salary_general)
      # puts salaries
      salaries['salaries'].each do |s|

        Occupation.create!(
          title: s['job']['title'],
          salary: (s['salary_percentiles']['percentile_50'] / 12).round(),
          city: City.last
        )
      end


      city_score_detailed['categories'][3]['data'][1..-1].each do |cost|
        CostOfLiving.create!(
          title: cost['label'],
          price: cost['currency_dollar_value'],
          city: City.last
        )
      end
      # housing
      city_score_detailed['categories'][8]['data'][0...-1].each do |cost|
        CostOfLiving.create!(
          title: cost['label'],
          price: cost['currency_dollar_value'],
          city: City.last
        )
      end
      # pollution
      city_score_detailed['categories'][15]['data'].each do |detail|
        CityDetail.create!(
          title: detail['label'],
          value: detail['float_value'],
          city: City.last
        )
      end
      # network
      city_score_detailed['categories'][13]['data'].each do |detail|
        CityDetail.create!(
          title: detail['label'],
          value: detail['float_value'],
          city: City.last
        )
      end
    end
  end
end

# --------------- photos ----------------

puts 'adding photo to Istanbul'
City.find_by(title: 'Istanbul').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1599581425921-726fd0056137?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'),
  filename: 'istanbul.jpg',
  content_type: 'image/jpg'
)

puts 'adding photo to Berlin'
City.find_by(title: 'Berlin').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1560969184-10fe8719e047?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
  filename: 'berlin.jpg',
  content_type: 'image/jpg'
)

puts 'adding photo to Frankfurt'
City.find_by(title: 'Frankfurt').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1577185816322-21f2a92b1342?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
  filename: 'frankfurt.jpg',
  content_type: 'image/jpg'
)

puts 'adding photo to Amsterdam'
City.find_by(title: 'Amsterdam').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1468436385273-8abca6dfd8d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1294&q=80'),
  filename: 'amsterdam.jpg',
  content_type: 'image/jpg'
)

puts 'adding photo to Stockholm'
City.find_by(title: 'Stockholm').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1497217968520-7d8d60b7bc25?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
  filename: 'stockholm.jpg',
  content_type: 'image/jpg'
)

puts 'adding photo to Paris'
City.find_by(title: 'Paris').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1454386608169-1c3b4edc1df8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'),
  filename: 'paris.jpg',
  content_type: 'image/jpg'
)

puts 'adding photo to Madrid'
City.find_by(title: 'Madrid').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1547636780-e41778614c28?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1351&q=80'),
  filename: 'madrid.jpg',
  content_type: 'image/jpg'
)


# ---------users----------

puts 'finding users living in Istanbul'


2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'Istanbul')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Istanbul'
  )

  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )

  UserCity.create!(
    title: 'Istanbul',
    user: User.last,
    city: City.find_by(title: 'Istanbul')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Istanbul'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Istanbul')).order("RANDOM()").first
  )

end

puts 'finding users living in Berlin'

2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Berlin',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )
  UserCity.create!(
    title: 'Berlin',
    user: User.last,
    city: City.find_by(title: 'Berlin')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Berlin'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Berlin')).order("RANDOM()").first
  )
end

puts 'finding users living in Amsterdam'

2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'Istanbul')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Amsterdam',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )

  UserCity.create!(
    title: 'Amsterdam',
    user: User.last,
    city: City.find_by(title: 'Amsterdam')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Amsterdam'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Amsterdam')).order("RANDOM()").first
  )
end

puts 'finding users living in Stockholm'

2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'Istanbul')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Stockholm',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )
  UserCity.create!(
    title: 'Stockholm',
    user: User.last,
    city: City.find_by(title: 'Stockholm')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Stockholm'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Stockholm')).order("RANDOM()").first
  )
end

puts 'finding users living in Frankfurt'

2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'Istanbul')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Frankfurt',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )
  UserCity.create!(
    title: 'Frankfurt',
    user: User.last,
    city: City.find_by(title: 'Frankfurt')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Frankfurt'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Frankfurt')).order("RANDOM()").first
  )
end

puts 'finding users living in Paris'
2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'Istanbul')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Paris',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )
  UserCity.create!(
    title: 'Paris',
    user: User.last,
    city: City.find_by(title: 'Paris')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Paris'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Paris')).order("RANDOM()").first
  )
end

puts 'finding users living in Madrid'
2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'Istanbul')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Madrid',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )

  UserCity.create!(
    title: 'Madrid',
    user: User.last,
    city: City.find_by(title: 'Madrid')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Madrid'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Madrid')).order("RANDOM()").first
  )
end
