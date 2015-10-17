# Description:
#   Hubot script to show weather for a city, defaulting to Minneapolis, MN
#
# Dependencies:
#   moment
#
# Configuration:
#   None
#
# Commands:
#   hubot weather in <city> - Show today's forecast for a city
#
# Author:
#   TimothyStewart
moment = require 'moment'

module.exports = (robot) ->
  apiKey = '5f78d5ee8d0506b4b8f808a4e95c0dea';
  robot.respond /weather in (.*)/i, (msg) ->
    msg.http("http://api.openweathermap.org/data/2.5/weather?q=#{msg.match[1]}&units=imperial&appid=#{apiKey}")
    .header('Accept', 'application/json')
    .get() (err, res, body) ->
      data = JSON.parse(body)
      if data
        msg.send "\nForecast for #{moment.unix(data.dt).format('MMMM Do YYYY')} in #{data.name}, #{data.sys.country}
        \nhttp://openweathermap.org/img/w/#{data.weather[0].icon}.png
        \nCondition: #{data.weather[0].main}, #{data.weather[0].description}
        \nHigh: #{data.main.temp_min}°F
        \nLow: #{data.main.temp_max}°F
        \nHumidity: #{data.main.humidity}%
        \nCloudiness is: #{data.clouds.all}%
        \nSunrise: #{moment.unix(data.sys.sunrise).format('h:mm:ss a')}
        \nSunset: #{moment.unix(data.sys.sunset).format('h:mm:ss a')}
        \n\nLast updated: #{moment.unix(data.dt).format('MMMM Do YYYY, h:mm:ss a')}"
      else
        msg.send "The weather gods must be OoO.  Check back later."