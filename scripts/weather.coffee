# Description:
#   Hubot script to show weather for a city, TODO:// defaulting to Minneapolis, MN
#
# Dependencies:
#   moment
#
# Configuration:
#   HUBOT_OPENWEATHERMAP_API_KEY
#
# Commands:
#   hubot weather [in <city>] - Show today's forecast for a city
#
# Author:
#   Timothy Stewart
moment = require 'moment'
apiKey = process.env.HUBOT_OPENWEATHERMAP_API_KEY

module.exports = (robot) ->
   unless apiKey?
      robot.logger.warning "HUBOT_OPENWEATHERMAP_API_KEY has not been set."
  robot.respond /weather( in)?(.*)?/i, (msg) ->
    unless apiKey?
      msg.send "HUBOT_OPENWEATHERMAP_API_KEY has not been set.  Contact your admin to set it"
      return
    City = msg.match[2]
    City ?= "Minneapolis"
    msg.http("http://api.openweathermap.org/data/2.5/weather?q=#{City}&units=imperial&appid=#{apiKey}")
    .header('Accept', 'application/json')
    .get() (err, res, body) ->
      data = JSON.parse(body)
      if data
        msg.send "\nhttp://openweathermap.org/img/w/#{data.weather[0].icon}.png"
        msg.send "\nForecast for #{moment.unix(data.dt).format('MMMM Do YYYY')} in #{data.name}, #{data.sys.country}
        \nCondition: #{data.weather[0].main}, #{data.weather[0].description}
        \nHigh: #{data.main.temp_max}°F
        \nLow: #{data.main.temp_min}°F
        \nHumidity: #{data.main.humidity}%
        \nCloudiness is: #{data.clouds.all}%
        \nSunrise: #{moment.unix(data.sys.sunrise).format('h:mm:ss a')}
        \nSunset: #{moment.unix(data.sys.sunset).format('h:mm:ss a')}
        \n\nLast updated: #{moment.unix(data.dt).format('MMMM Do YYYY, h:mm:ss a')}"
      else
        msg.send "The weather gods must be OOO.  Check back later."
