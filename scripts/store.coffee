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
#   spotbot lookup store <storenumber> - List details about the requested store
#   spotbot (bullseye) <storenumber> - List details about the requested store
#   spotbot T<storenumber> - List details about the requested store
#
# Examples:
#   spotbot lookup store 1975
#   spotbot lookup store T-0848
#   spotbot (bullseye) 1975
#   spotbot (bullseye) T-0848
#   spotbot T1375
#   spotbot T 848
#   spotbot T-0848
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
  msg.send "Store Details for #{id} #{location.Name}"
  msg.send location.Address.FormattedAddress

  # Region Group District
  msg.send "Region: #{location.Store?.StoreRegionID}"
  msg.send "Group: #{location.Store?.StoreGroupID}"
  msg.send "District: #{location.Store?.StoreDistrictID}"

  # Store Type
  if location.SubTypeDescription
    msg.send "Type: #{location.SubTypeDescription}"
  else
    msg.send "Type: #{location.TypeDescription}"

  msg.send "Market: #{location.Market}"

  # Phone Numbers
  msg.send "#{phone.FunctionalTypeDescription}: #{phone.PhoneNumber}" for phone in location.TelephoneNumber

  # Milestones
  openDate = location.LocationMilestones?.OpenDate
  openDate = openDate?.match(/\d{4}-\d{2}-\d{2}/)
  msg.send "Open Date: #{openDate}"
  if remodleDate = location.LocationMilestones?.LastRemodelDate
    remodleDate = remodleDate.match(/\d{4}-\d{2}-\d{2}/)
    msg.send "Last Remodel Date: #{remodleDate}"

  # Hours
  msg.send "Time Zone: #{location.TimeZone?.TimeZoneCode}"
  msg.send "Hours:"
  msg.send "  #{hour.FullName}: #{hour.TimePeriod.Summary}" for hour in location.OperatingHours?.Hours

  # Capabilities
  msg.send "Capabilities:"
  for capability in location.Capability
    msg.send "  #{capability.CapabilityName}"
    if phoneNumber = capability.TelephoneNumber
      msg.send "    #{phoneNumber.PhoneNumber}"
    if hours = capability.OperatingHours
      for hour in hours.Hours
        msg.send "    #{hour.FullName}: #{hour.TimePeriod.Summary}"


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
