#!/usr/bin/env ruby
#
# Outputs the current weather for a location in your terminal
#
# When it gets run it simply outputs the
# current weather for a given city (or your
# current location if none is given) in your terminal.
#
# OPTIONS:
#   --help, -h          Show this help message
#
# USAGE:
#   $ ./weather
#   # => Outputs the weather for your current location
#   $ ./weather.sh "SãoPauloBR"
#   # => Outputs the weather for São Paulo, Brazil
#   $ ./weather --help
#   # => Outputs help message
#
# OS SUPPORT:
#   Linux and MacOS
#
# SOURCE:
#   https://github.com/lsfernandes92/awesome-scripts/tree/main/public/bins/weather/
require 'json'

WEATHER_API_URL = "https://wttr.in"

location = ARGV.reject { |arg| arg.start_with?('-') }.first
query_path = location ? "/#{location}" : "/"

string_response = `curl -s "#{WEATHER_API_URL}#{query_path}?format=j1" 2>/dev/null`

begin
  hash_response = JSON.parse(string_response)
rescue JSON::ParserError
  puts "󱄋 Try again later."
  exit 1
end

current_condition = hash_response.dig('current_condition', 0)
description = current_condition.dig('weatherDesc', 0, 'value')
temp_c = current_condition.dig('temp_C')

def daytime?(time = Time.now)
  hour = time.hour
  (6..18).cover?(hour)
end

ICONS = {
  thunder:       { day: "", night: "" },
  snow:          { day: "", night: "" },
  rain:          { day: "", night: "" },
  fog:           { day: "", night: "" },
  overcast:      { day: "", night: "" },
  partly_cloudy: { day: "", night: "" },
  clear:         { day: "", night: "" },
  default:       { day: "", night: "" } 
}.freeze

def icon_for(description, daytime)
  period = daytime ? :day : :night

  key = case description.downcase
        when /thunder/              then :thunder
        when /snow|sleet|ice/       then :snow
        when /rain|drizzle|shower/  then :rain
        when /fog|mist|haze/        then :fog
        when /overcast/             then :overcast
        when /partly cloudy|cloudy/ then :partly_cloudy
        when /clear|sunny/          then :clear
        else                             :default
        end

  ICONS[key][period]
end

def display_weather(icon, label)
  return system("sketchybar", "--set", ENV['NAME'], "icon=#{icon}", "label=#{label}") if sketchybar_context?
  
  puts "#{icon} #{label}"
end

def sketchybar_context?
  ENV['NAME'] ? true : false
end

daytime = daytime?
icon = icon_for(description, daytime)
label = "#{temp_c}°C"
puts $CONFIG_DIR
display_weather(icon, label)