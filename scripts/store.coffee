# Description:
#   With the Enterprise Services Location API return details about a store
#
# Dependencies:
#   None
#
# Configuration:
#   SPOTBOT_TGT_API_KEY
#
#   Generate a Enterprise Services API key for for use
#
# Commands:
#   hubot lookup store <storenumber> - List details about the requested store
#   hubot (bullseye) <storenumber> - List details about the requested store
#   hubot T<storenumber> - List details about the requested store
#
# Examples:
#   hubot lookup store 1975
#   hubot lookup store T-0848
#   hubot (bullseye) 1975
#   hubot (bullseye) T-0848
#   hubot T1375
#   hubot T 848
#   hubot T-0848
#
# Author:
#   Erik.Kringen
#

zlib = require('zlib')

api_key = process.env.SPOTBOT_TGT_API_KEY

lookupStore = (msg) ->
  text = msg.match[1]
  number = text.match(/[0-9]+/)
  number = parseInt(number, 10)

  unless api_key?
    msg.send "Could not read the SPOTBOT_TGT_API_KEY value. Please contact the bot administrator."
    return
  data = ""
  robot.http("http://api.target.com/v2/store/#{number}?key=#{api_key}")
    .header('Accept', 'application/json')
    .get( (err, req) ->
      req.addListener "response", (res)->
        output = res
        if err
          msg.send "Error when trying to get details for T-#{number}"
        if res.statusCode == 404
          msg.send "#{number} is not a open Target Store"
          return
        unless res.statusCode == 200
          msg.send "Received #{res.statusCode} when trying to get details for T-#{number}"
          return
        #pattern from http://stackoverflow.com/questions/10207762/how-to-use-request-or-http-module-to-read-gzip-page-into-a-string
        if res.headers['content-encoding'] is 'gzip'
          output = zlib.createGunzip()
          res.pipe(output)

        output.on 'data', (d)->
          data += d.toString('utf-8')

        output.on 'end', ()->
          parsedData = JSON.parse(data)
          sayDetails parsedData, msg
    )()

sayDetails = (json, msg) ->
  location = json.Location
  if location == null
    msg.send "There was an error looking up store details :()"
  if id = location.AlternateIdentifier?.ID
    id = id.replace('T', 'T-')
  else
    id = "T-#{location.ID}"
  response = "Store Details for #{id} #{location.Name}\n#{location.Address.FormattedAddress}\nRegion: #{location.Store?.StoreRegionID}\nGroup: #{location.Store?.StoreGroupID}\nDistrict: #{location.Store?.StoreDistrictID}\n"

  # Store Type
  if location.SubTypeDescription
    response += "Type: #{location.SubTypeDescription}\n"
  else
    response += "Type: #{location.TypeDescription}\n"

  response += "Market: #{location.Market}\n"

  # Phone Numbers
  response += "#{phone.FunctionalTypeDescription}: #{phone.PhoneNumber}\n" for phone in location.TelephoneNumber

  # Milestones
  openDate = location.LocationMilestones?.OpenDate
  openDate = openDate?.match(/\d{4}-\d{2}-\d{2}/)
  response += "Open Date: #{openDate}\n"
  if remodleDate = location.LocationMilestones?.LastRemodelDate
    remodleDate = remodleDate.match(/\d{4}-\d{2}-\d{2}/)
    response += "Last Remodel Date: #{remodleDate}\n"

  # Hours
  response += "Time Zone: #{location.TimeZone?.TimeZoneCode}\nHours:\n"
  response += "  #{hour.FullName}: #{hour.TimePeriod.Summary}\n" for hour in location.OperatingHours?.Hours

  # Capabilities
  capabilities = location.Capability
  unless capabilities != null
      msg.send response
      return
  unless typeIsArray capabilities
    capabilities = [capabilities]
  response += "Capabilities:\n"
  for capability in capabilities
    response += "  #{capability.CapabilityName}\n"
    if phoneNumber = capability.TelephoneNumber
      if singlePhoneNumber = phoneNumber.PhoneNumber
        response += "    #{phoneNumber.PhoneNumber}\n"
      else
        response += "    #{phone.FunctionalTypeDescription}: #{phone.PhoneNumber}\n" for phone in phoneNumber
    if hours = capability.OperatingHours
      for hour in hours.Hours
        response += "    #{hour.FullName}: #{hour.TimePeriod.Summary}\n"
  msg.send response

module.exports = (robot) ->
  # On initialization, if we couldn't find the key, we should log a warning
  unless api_key?
    robot.logger.warning "The SPOTBOT_TGT_API_KEY environment variable not set"

  robot.respond /lookup store (.+)/i, (msg) ->
    lookupStore msg
  robot.respond /\(bullseye\) (.+)/i, (msg) ->
    lookupStore msg
  robot.respond /(T.?\d{1,4})/i, (msg) ->
    lookupStore msg

# From CoffeeScript Cookbook https://coffeescript-cookbook.github.io/chapters/arrays/check-type-is-array
typeIsArray = Array.isArray || ( value ) -> return {}.toString.call( value ) is '[object Array]'
