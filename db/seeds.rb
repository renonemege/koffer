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
UserOccupation.destroy_all
UserInterest.destroy_all
Response.destroy_all
Survey.destroy_all
User.destroy_all
Occupation.destroy_all
Interest.destroy_all
CostOfLiving.destroy_all
CityDetail.destroy_all
City.destroy_all




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

Interest.create!(
  title: 'Sports'
)
Interest.create!(
  title: 'Technology'
)

Interest.create!(
  title: 'Photography'
)

Interest.create!(
  title: 'Gardening'
)

Interest.create!(
  title: 'Cooking'
)

Interest.create!(
  title: 'Dancing'
)

Interest.create!(
  title: 'Camping'
)

Interest.create!(
  title: 'Board Games'
)
# San\ Fransisco Berlin Frankfurt Amsterdam Stockholm Paris Madrid
# --------cities--------------
cities = %w[Istanbul Berlin Frankfurt Amsterdam Stockholm Paris Madrid Glasgow Rome Vienna Rotterdam Prague London Lisbon Budapest Barcelona Copenhagen Warsaw Dublin]

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
# Glasgow Rome Vienna Rotterdam Prague London Lisbon Budapest Barcelona Copenhagen Warsaw Dublin]
puts 'adding photo to Glasgow'
City.find_by(title: 'Glasgow').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1531152369337-1d0b0b9ef20d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
  filename: 'glasgow.jpg',
  content_type: 'image/jpg'
)

puts 'adding photo to Rome'
City.find_by(title: 'Rome').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1525874684015-58379d421a52?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
  filename: 'rome.jpg',
  content_type: 'image/jpg'
)

puts 'adding photo to Vienna'
City.find_by(title: 'Vienna').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1533192051774-c77ea3802005?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=664&q=80'),
  filename: 'vienna.jpg',
  content_type: 'image/jpg'
)

puts 'adding photo to Rotterdam'
City.find_by(title: 'Rotterdam').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1542989364-953d211f4b6a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1347&q=80'),
  filename: 'rotterdam.jpg',
  content_type: 'image/jpg'
)

puts 'adding photo to Prague'
City.find_by(title: 'Prague').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1541849546-216549ae216d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
  filename: 'prague.jpg',
  content_type: 'image/jpg'
)

puts 'adding photo to London'
City.find_by(title: 'London').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1526129318478-62ed807ebdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'),
  filename: 'london.jpg',
  content_type: 'image/jpg'
)


puts 'adding photo to Lisbon'
City.find_by(title: 'Lisbon').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1542475393-3859feead00d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
  filename: 'lisbon.jpg',
  content_type: 'image/jpg'
)

puts 'adding photo to Budapest'
City.find_by(title: 'Budapest').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1549877452-9c387954fbc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
  filename: 'budapest.jpg',
  content_type: 'image/jpg'
)

puts 'adding photo to Barcelona'
City.find_by(title: 'Barcelona').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1587043211963-0352f1528f6a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
  filename: 'barcelona.jpg',
  content_type: 'image/jpg'
)

puts 'adding photo to Copenhagen'
City.find_by(title: 'Copenhagen').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1521240104483-b3e91583366c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80'),
  filename: 'copenhagen.jpg',
  content_type: 'image/jpg'
)

puts 'adding photo to Warsaw'
City.find_by(title: 'Warsaw').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1506549209434-33eff06262cc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1856&q=80'),
  filename: 'warsaw.jpg',
  content_type: 'image/jpg'
)

puts 'adding photo to Dublin'
City.find_by(title: 'Dublin').photo.attach(
  io: URI.open('https://images.unsplash.com/photo-1549918864-48ac978761a4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
  filename: 'dublin.jpg',
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

# 2.times do
#   User.create!(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     email: Faker::Internet.email ,
#     password: Faker::Internet.password(min_length: 8),
#     username: Faker::Internet.username,
#     description: Faker::JapaneseMedia::StudioGhibli.quote,
#     current_city: 'Berlin',
#   )
#   User.last.avatar.attach(
#     io: URI.open('https://source.unsplash.com/random'),
#     filename: 'user.jpg',
#     content_type: 'image/jpg'
#   )
#   UserCity.create!(
#     title: 'Berlin',
#     user: User.last,
#     city: City.find_by(title: 'Berlin')
#   )

#   UserOccupation.create!(
#     city: City.find_by(title: 'Berlin'),
#     user: User.last,
#     occupation: Occupation.where(city: City.find_by(title: 'Berlin')).order("RANDOM()").first
#   )
# end

puts 'adding Sy'

  User.create!(
    first_name: 'Sy',
    last_name: 'Rashid',
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Berlin',
  )
  User.last.avatar.attach(
    io: URI.open('https://ca.slack-edge.com/T02NE0241-UKUNBJ7DX-9126197b4f3d-512'),
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
    occupation: Occupation.where(city: City.find_by(title: 'Berlin'), title: 'Web Developer' ).first
  )

puts 'adding Edvar'

  User.create!(
    first_name: 'Edvar',
    last_name: 'ter Haar',
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Berlin',
  )
  User.last.avatar.attach(
    io: URI.open('https://ca.slack-edge.com/T02NE0241-UHGH1JLQ1-a045e6d83f92-512'),
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
    occupation: Occupation.where(city: City.find_by(title: 'Berlin'), title: 'Web Developer').first
  )

puts 'adding Nico'

User.create!(
    first_name: 'Nico',
    last_name: 'Proto',
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Berlin',
  )
  User.last.avatar.attach(
    io: URI.open('https://ca.slack-edge.com/T02NE0241-UKPKXKN3V-93cd441dc801-512'),
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
    occupation: Occupation.where(city: City.find_by(title: 'Berlin'), title: 'Web Developer').first
  )


puts 'adding Yair'

User.create!(
    first_name: 'Yair',
    last_name: 'Gordon',
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Berlin',
  )
  User.last.avatar.attach(
    io: URI.open('https://ca.slack-edge.com/T02NE0241-ULMJDQKHP-92839c14cc51-512'),
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
    occupation: Occupation.where(city: City.find_by(title: 'Berlin'), title: 'Web Developer').first
  )



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
    occupation: Occupation.where(city: City.find_by(title: 'Madrid')).order("RANDOM()").first,
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



puts 'finding users living in Glasgow'
2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'Glasgow')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Glasgow',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )

  UserCity.create!(
    title: 'Glasgow',
    user: User.last,
    city: City.find_by(title: 'Glasgow')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Glasgow'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Glasgow')).order("RANDOM()").first
  )
end


puts 'finding users living in Vienna'
2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'Vienna')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Vienna',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )

  UserCity.create!(
    title: 'Vienna',
    user: User.last,
    city: City.find_by(title: 'Vienna')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Vienna'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Vienna')).order("RANDOM()").first
  )
end

puts 'finding users living in Rome'
2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'Rome')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Rome',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )

  UserCity.create!(
    title: 'Rome',
    user: User.last,
    city: City.find_by(title: 'Rome')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Rome'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Rome')).order("RANDOM()").first
  )
end

puts 'finding users living in Rotterdam'
2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'Rotterdam')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Rotterdam',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )

  UserCity.create!(
    title: 'Rotterdam',
    user: User.last,
    city: City.find_by(title: 'Rotterdam')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Rotterdam'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Rotterdam')).order("RANDOM()").first
  )
end

puts 'finding users living in Prague'
2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'Prague')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Prague',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )

  UserCity.create!(
    title: 'Prague',
    user: User.last,
    city: City.find_by(title: 'Prague')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Prague'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Prague')).order("RANDOM()").first
  )
end

puts 'finding users living in London'
2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'London')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'London',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )

  UserCity.create!(
    title: 'London',
    user: User.last,
    city: City.find_by(title: 'London')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'London'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'London')).order("RANDOM()").first
  )
end

puts 'finding users living in Lisbon'
2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'Lisbon')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Lisbon',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )

  UserCity.create!(
    title: 'Lisbon',
    user: User.last,
    city: City.find_by(title: 'Lisbon')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Lisbon'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Lisbon')).order("RANDOM()").first
  )
end

puts 'finding users living in Budapest'
2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'Budapest')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Budapest',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )

  UserCity.create!(
    title: 'Budapest',
    user: User.last,
    city: City.find_by(title: 'Budapest')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Budapest'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Madrid')).order("RANDOM()").first
  )
end

puts 'finding users living in Barcelona'
2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'Barcelona')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Barcelona',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )

  UserCity.create!(
    title: 'Barcelona',
    user: User.last,
    city: City.find_by(title: 'Barcelona')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Barcelona'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Barcelona')).order("RANDOM()").first
  )
end

puts 'finding users living in Copenhagen'
2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'Copenhagen')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Copenhagen',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )

  UserCity.create!(
    title: 'Copenhagen',
    user: User.last,
    city: City.find_by(title: 'Copenhagen')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Copenhagen'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Copenhagen')).order("RANDOM()").first
  )
end
# -----cities = %w[ Budapest Barcelona Copenhagen Warsaw Dublin]

puts 'finding users living in Warsaw'
2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'Warsaw')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Warsaw',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )

  UserCity.create!(
    title: 'Warsaw',
    user: User.last,
    city: City.find_by(title: 'Warsaw')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Warsaw'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Warsaw')).order("RANDOM()").first
  )
end

puts 'finding users living in Dublin'
2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email ,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.username,
    occupation: Occupation.where(city: City.find_by(title: 'Dublin')).order("RANDOM()").first,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    current_city: 'Dublin',
  )
  User.last.avatar.attach(
    io: URI.open('https://source.unsplash.com/random'),
    filename: 'user.jpg',
    content_type: 'image/jpg'
  )

  UserCity.create!(
    title: 'Dublin',
    user: User.last,
    city: City.find_by(title: 'Dublin')
  )

  UserOccupation.create!(
    city: City.find_by(title: 'Dublin'),
    user: User.last,
    occupation: Occupation.where(city: City.find_by(title: 'Dublin')).order("RANDOM()").first
  )
end
