require 'rest-client'

class WeatherService
  def self.fetch_weather(city)
    # OpenWeatherMap APIからデータを取得するリクエストを行う
    response = RestClient.get("http://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=4b0a3d10b660331f0b2916783fdd290d&units=metric")
    weather_data = JSON.parse(response.body) 
    
    puts weather_data 
    {
      icon: weather_data['weather'][0]['icon'],
      high: weather_data['main']['temp_max'],
      low: weather_data['main']['temp_min'],
      city: weather_data['name'] # 都市名を取得
    }
  end
end
