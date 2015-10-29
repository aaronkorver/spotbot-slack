# Description:
#   Hubot script to show weather for a city
#
# Dependencies:
#   moment
#
# Configuration:
#   HUBOT_OPENWEATHERMAP_API_KEY
#
# Commands:
#   hubot weather [in <city>] - Show today's forecast for a city, (default: Minneapolis)
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
    data = {}
    tempMinMax = {}
    #getting most of the current weather data
    msg.http("http://api.openweathermap.org/data/2.5/weather?q=#{City}&units=imperial&appid=#{apiKey}")
    .header('Accept', 'application/json')
    .get() (err, res, body) ->
      data = JSON.parse(body)

      #getting forecasted min and max temps for the day
      msg.http("http://api.openweathermap.org/data/2.5/forecast/daily?q=#{City}&units=imperial&cnt=1&appid=#{apiKey}")
      .header('Accept', 'application/json')
      .get() (err, res, body) ->
        tempMinMax = JSON.parse(body)

        if data && tempMinMax
          msg.send "\nForecast for #{moment.unix(data.dt).format('MMMM Do YYYY')} in #{data.name}, #{data.sys.country}
          \nCurrent Conditions: #{data.main.temp}°F, #{data.weather[0].main}, #{data.weather[0].description}
          \nHigh: #{tempMinMax.list[0].temp.max}°F
          \nLow: #{tempMinMax.list[0].temp.min}°F
          \nHumidity: #{data.main.humidity}%
          \nCloudiness is: #{data.clouds.all}%
          \nSunrise: #{moment.unix(data.sys.sunrise).format('h:mm:ss a')}
          \nSunset: #{moment.unix(data.sys.sunset).format('h:mm:ss a')}
          \n\nLast updated: #{moment.unix(data.dt).format('MMMM Do YYYY, h:mm:ss a')}"
        else
          msg.send "The weather gods must be OOO.  Check back later."
