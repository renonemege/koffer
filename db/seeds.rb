# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

City.destroy_all

cities = ['Istanbul', 'San Fransisco', 'Berlin', 'Frankfurt', 'Amsterdam', 'Stockholm', 'Paris', 'Madrid']

# Gets all cities
teleport_api_cities = open('https://api.teleport.org/api/urban_areas/').read
the_city = JSON.parse(teleport_api_cities)

cities.each do |seed_city|
  # Iterate through each city and find the ones provided in cities#array

  the_city['_links']['ua:item'].each do |city|
    if city['name'] == seed_city
      puts seed_city

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

        # city_score_detailed['categories']['data'][3].each do |data|
        #   puts data['label']
        #   puts data['id']
        # end

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

