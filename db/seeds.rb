# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"

City.destroy_all

cities = ['Istanbul', 'San Fransisco', 'Berlin', 'Frankfurt', 'Amsterdam', 'Stockholm', 'Paris', 'Madrid']

# Gets all cities
teleport_api_cities = open('https://api.teleport.org/api/urban_areas/').read
the_city = JSON.parse(teleport_api_cities)


# ------------ create cities ---------------
cities.each do |seed_city|
  # Iterate through each city and find the ones provided in cities#array

  the_city['_links']['ua:item'].each do |city|
    if city['name'] == seed_city
      puts "Creating #{seed_city}"

      city_score_url = city['href'] # get the url for the city
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

      seed_city = City.create!(
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
