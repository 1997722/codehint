class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_weather_info

  def set_weather_info
    @city_weather = WeatherService.fetch_weather('Tokyo') # 都市名を指定
  end
  
  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end
