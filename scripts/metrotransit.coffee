# Description:
#   Allows user to check MetroTransit NextTrip times
#   Based off of https://github.com/github/hubot-scripts/blob/master/src/scripts/tctransit.coffee updated to use MetroTransit provided APIs
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot when is the next <route #> going <north/south/east/west> from <4 letter stop code OR stop name>
#   hubot what stops are on <route #> going <north/south/east/west>
#   hubot (transit|(metrotransit)) routes
#
# Examples:
#   hubut when is the next green line going east from Nicollet Mall
#   hubot what stops are on 3 going west
#   hubot transit routes
#   hubot (metrotransit) routes

# Author:
#   Erik.Kringen

module.exports = (robot) ->
  robot.respond /when is the next (.*) going (.*) from (.*)/i, (msg) ->
    route = msg.match[1].toLowerCase()
    unless routeNum = getRouteNumber(route)
      msg.send "#{route} is not a valid route number\nSee '#{robot.name} transit routes' for all avalible routes"
      return
    direction = msg.match[2]
    dirNum = getDirectionNumber(direction.toLowerCase())

    stop = msg.match[3]
    if (stop.length > 4)
      TransitAPI.search_stop_codes(routeNum, dirNum, stop, msg)
    else
      TransitAPI.fetch_next_stop(routeNum, dirNum, stop, msg)

  robot.respond /what stops are on (.*) going (.*)/i, (msg) ->
    route = msg.match[1].toLowerCase()
    unless routeNum = getRouteNumber(route)
      msg.send "#{route} is not a valid route number\nSee '#{robot.name} transit routes' for all avalible routes"
      return
    direction = msg.match[2]
    dirNum = getDirectionNumber(direction.toLowerCase())
    TransitAPI.list_stops(routeNum, dirNum, msg)

  robot.respond /(transit|\(metrotransit\)) routes/i, (msg) ->
    TransitAPI.list_routes(msg)

class TransitAPI
  constructor: ->

  fetch_next_stop: (route, dirNum, stopCode, msg) =>
    msg.http("http://svc.metrotransit.org/NexTrip/#{route}/#{dirNum}/#{stopCode}")
      .header('Accept', 'application/json')
      .get() (err, res, body) =>
        if err
          msg.send "Error loading trips for the given route and stop"
          return
        trips = JSON.parse(body)
        if trips.length <= 0
          msg.send "Couldn't find any NextTrips make sure the route and stop are correct\n'#{robot.name} transit routes'\n'#{robot.name} what stops are on <route #> going <north/south/east/west>'"
          return
        data = []
        longestRoute = 0
        longestDescription = 0
        for trip in trips
          time = trip.DepartureText
          route = trip.Route + trip.Terminal
          if route.length > longestRoute
            longestRoute = route.length
          description = trip.Description
          if description.length > longestDescription
            longestDescription = description.length
          data.push {
            route: route,
            description: description,
            time: time
          }
        msg.send "/code #{prettyPrint(data, longestRoute, longestDescription)}"

  search_stop_codes: (route, dirNum, stopName, msg) =>
    msg.http("http://svc.metrotransit.org/NexTrip/Stops/#{route}/#{dirNum}")
      .header('Accept', 'application/json')
      .get() (err, res, body) =>
        if err
          msg.send "Error finding stops for #{route} going #{getDirection(dirNum)}. Makre sure the route is correct\n'#{robot.name} transit routes'"
          return
        stops = JSON.parse(body)
        # too bad, no stops found for this
        if stops.length <= 0
          msg.send "No stops available for the #{route} going #{getDirection(dirNum)}"
          return
        # see if any of our stops match
        for stop in stops
          if stop.Text.toLowerCase().indexOf(stopName.toLowerCase()) > -1
            this.fetch_next_stop(route, dirNum, stop.Value, msg)
            return
        msg.send "No stops found with name: #{stopName}\nTry #{robot.name} what stops are on #{route} going #{getDirection(dirNum)}"

  list_stops: (route, dirNum, msg) =>
    msg.http("http://svc.metrotransit.org/NexTrip/Stops/#{route}/#{dirNum}")
      .header('Accept', 'application/json')
      .get() (err, res, body) =>
        if err
          msg.send "Error finding stops for #{route}"
          return
        stops = JSON.parse(body)
        # too bad, no stops found for this
        if stops.length <= 0
          msg.send "No stops available for the #{route} going #{getDirection(dirNum)}"
          return

        stopText = "#{getDirection(dirNum)}bound stops on #{route}\nStop Code     Description\n"
        for stop in stops
          spaces = Array((4 - stop.Value.length) + 1).join ' '
          stopText += "#{stop.Value}#{spaces}          #{stop.Text}\n"
        msg.send "/code #{stopText}"

  list_routes: (msg) =>
    msg.http('http://svc.metrotransit.org/NexTrip/Routes')
    .header('Accept', 'application/json')
    .get() (err, res, body) =>
      if err
        msg.send 'Error loading (metrotransit) routes :('
        return
      routes = JSON.parse(body)

      if routes.length <= 0
        msg.send "Couldn't find any (metrotransit) routes"
        return

      longestRow = 0

      routesText = 'All (metrotransit) routes in service today:\nRoute #    Description\n'
      for route in routes
        spaces = Array((7 - route.Route.length) + 1).join ' '
        rowText = "#{route.Route}#{spaces}    #{route.Description}\n"
        routesText += rowText
        if rowText.length > longestRow
          longestRow = rowText.length
      routesText += Array(longestRow + 1).join '-'
      routesText += "\nUse '#{robot.name} what stops are on <route #> going <north/south/east/west>' to determine the stops on this route\n"
      msg.send "/code #{routesText}"

TransitAPI = new TransitAPI()

# Normalize the route, ie return light rail route numbers, trip terminals of specific routes
getRouteNumber = (route) ->
  unless routeNum = parseInt(route, 10)
    if route.indexOf('blue') != -1
      routeNum = 901
    else if route.indexOf('green') != -1
      routeNum = 902
    else if route.indexOf('red') != -1
      routeNum = 903
    else if route.indexOf('northstar') != -1
      routeNum = 888
    else
      routeNum = null
  return routeNum

# Get direction number from direction name
getDirectionNumber = (direction) ->
  dirNum = 4
  if direction.toLowerCase() == 'east'
    dirNum = 2
  else if direction.toLowerCase() == 'west'
    dirNum = 3
  else if direction.toLowerCase() == 'south'
    dirNum = 1
  return dirNum

# Get direction form direction number
getDirection = (directionNumber) ->
    direction = 'north'
    if directionNumber == 2
      direction = 'east'
    else if directionNumber == 3
      direction = 'west'
    else if directionNumber == 1
      direction = 'south'
    return direction
# Properly padds the output
prettyPrint = (trips, longestRoute, longestDescription) ->
  response = ""
  for trip in trips
    numSpaceAfterRoute = longestRoute - trip.route.length
    spacesAfterRoute = Array(numSpaceAfterRoute + 1).join ' '
    numSpaceAfterDescription = longestDescription - trip.description.length
    spacesAfterDescription = Array(numSpaceAfterDescription + 1).join ' '
    response += "#{trip.route}#{spacesAfterRoute}    #{trip.description}#{spacesAfterDescription}   #{trip.time}\n"
  return response
