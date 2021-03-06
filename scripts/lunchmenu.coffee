# Description:
#   None
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot menu CC - Gives url for CC lunch menu
#   hubot menu TNC - Gives url for TNC lunch menu
#   hubot menu TPS - Gives url for TPS lunch menu
#
# Author:
#   Jordan McGowan

ccMenu = "http://target.cafebonappetit.com/cafe/bullseye-cafe/" #273
tncMenu = "http://target.cafebonappetit.com/cafe/traders-point/" #274
tpsMenu = "http://target.cafebonappetit.com/cafe/cafe-target/" #272

cityCenterPattern = /C(ity)?\s?C(enter)?/i
targetNorthCampusPattern = /\b(T(arget)?\s?N(orth)?\s?C(ampus)?)|BFE\b/i
targetPlaza3Pattern = /\bT(arget)?\s?P(laza)?\s?(3|Three)\b/i
targetPlazaCommonsPattern = /\bT(arget)?\s?P(laza)?\s?C(ommons)?\b/i
targetPlazaNorthPattern = /\bT(arget)?\s?P(laza)?\s?N(orth)?\b/i
targetPlazaSouthPattern = /\bT(arget)?\s?P(laza)?\s?S(outh)?\b/i

textToSend = ""
cafeInfo = ""
count = 0


module.exports = (robot) ->

  #Pulls in user input in the form of 'menu <location> <query>'
  robot.respond /(menu)\s+([a-zA-Z0-9_\-]+)\s?([a-zA-Z0-9_\-]*)?\s?([a-zA-Z0-9_\-]*)?/i, (msg) ->

    location = msg.match[2].toLowerCase()

    switch
      when location?.match( cityCenterPattern ) then location = "cc"
      when location?.match( targetNorthCampusPattern ) then location = "tnc"
      when location?.match( targetPlaza3Pattern ) then location = "tps"
      when location?.match( targetPlazaCommonsPattern ) then location = "tps"
      when location?.match( targetPlazaNorthPattern ) then location = "tps"
      when location?.match( targetPlazaSouthPattern ) then location = "tps"

    if msg.match[3]?
      bfastOrLunch = msg.match[3].toLowerCase()
    if msg.match[4]?
      foodItem = msg.match[4].toLowerCase()

    if location == "cc"
      cafeNum = "273"
      msg.send "CC Menu: " + ccMenu
      if !foodItem? && bfastOrLunch?
        getAllCafeInfo msg, cafeNum, bfastOrLunch, foodItem
      else if foodItem? && bfastOrLunch?
        getSpecificCafeInfo msg, cafeNum, bfastOrLunch, foodItem


    if location == "tnc"
      cafeNum = "274"
      msg.send "TNC Menu " + tncMenu
      if !foodItem? && bfastOrLunch?
        getAllCafeInfo msg, cafeNum, bfastOrLunch, foodItem
      else if foodItem? && bfastOrLunch?
        getSpecificCafeInfo msg, cafeNum, bfastOrLunch, foodItem

    if location == "tps"
      cafeNum = "272"
      msg.send "TPS Menu " + tpsMenu
      if !foodItem? && bfastOrLunch?
        getAllCafeInfo msg, cafeNum, bfastOrLunch, foodItem
      else if foodItem? && bfastOrLunch?
        getSpecificCafeInfo msg, cafeNum, bfastOrLunch, foodItem

  #returns all items avail at the cafe
  getAllCafeInfo = (msg, cafeNum, bfastOrLunch, itemToEat) ->
    msg.http('http://legacy.cafebonappetit.com/api/2/menus?format=jsonp&cafe=' + cafeNum)
      .get() (err, res, body) ->
        cafeInfo = JSON.parse(body)
        #Filter cafes from items
        explicitCafeInfo = cafeInfo.days[0].cafes[cafeNum].dayparts[0]
        #Get num options -- should be 2 (bfast & lunch)
        dayPartsLength = explicitCafeInfo.length
        #Split the bfast and lunch options
        for i in [0...dayPartsLength]
          #bfast
          if explicitCafeInfo[i].label == "Breakfast" && bfastOrLunch == "breakfast"
            bfastInfo = explicitCafeInfo[i].stations
            numBfastStations = bfastInfo.length
            sendCafeInfoMessage(bfastInfo, numBfastStations, cafeInfo, msg)
          #lunch
          if explicitCafeInfo[i].label == "Lunch" && bfastOrLunch == "lunch"
            lunchInfo = explicitCafeInfo[i].stations
            numLunchStations = lunchInfo.length
            sendCafeInfoMessage(lunchInfo, numLunchStations, cafeInfo, msg)

  #returns info based on custom query for food items
  getSpecificCafeInfo = (msg, cafeNum, bfastOrLunch, itemToEat) ->
    msg.http('http://legacy.cafebonappetit.com/api/2/menus?format=jsonp&cafe=' + cafeNum)
      .get() (err, res, body) ->
        cafeInfo = JSON.parse(body)
        #Filter cafes from items
        explicitCafeInfo = cafeInfo.days[0].cafes[cafeNum].dayparts[0]
        #Get num options -- should be 2 (bfast & lunch)
        dayPartsLength = explicitCafeInfo.length
        #Split the bfast and lunch options
        for i in [0...dayPartsLength]
          #bfast
          if explicitCafeInfo[i].label == "Breakfast" && bfastOrLunch == "breakfast"
            bfastInfo = explicitCafeInfo[i].stations
            numBfastStations = bfastInfo.length
            sendQueryInfoMessage(bfastInfo, numBfastStations, cafeInfo, itemToEat, msg)
          #lunch
          if explicitCafeInfo[i].label == "Lunch" && bfastOrLunch == "lunch"
            lunchInfo = explicitCafeInfo[i].stations
            numLunchStations = lunchInfo.length
            sendQueryInfoMessage(lunchInfo, numLunchStations, cafeInfo, itemToEat, msg)

  sendCafeInfoMessage = (bfastOrLunchInfo, numStations, cafeInfo, msg) ->
    #Step thru all of the stations at the cafe
    for j in [0...numStations]
      stationInfo = bfastOrLunchInfo[j]
      stationName = bfastOrLunchInfo[j].label.toUpperCase()
      numItemsAtStation = stationInfo.items.length
      textToSend = textToSend + "\nFood available at " + stationName + " station"
      #Step thru all of the items at the station
      for k in [0...numItemsAtStation]
        itemNumber = stationInfo.items[k]
        singleItem = cafeInfo.items[itemNumber]
        itemName = singleItem.label
        itemPrice = singleItem.price
        itemCals = singleItem.nutrition.kcal
        if itemCals != ""
          if k == numItemsAtStation - 1
            #special case to add new line char to end of a section
            textToSend = textToSend + "\n" + "---" + itemName + " for " + itemPrice + " with " + itemCals + " calories\n"
          else
            textToSend = textToSend + "\n" + "---" + itemName + " for " + itemPrice + " with " + itemCals + " calories"
        if itemCals == ""
          #special case to add new line char to end of a section
          if k == numItemsAtStation - 1
            textToSend = textToSend + "\n" + "---" + itemName + " for " + itemPrice + "\n"
          else
            textToSend = textToSend + "\n" + "---" + itemName + " for " + itemPrice
    msg.send textToSend
    textToSend = ""

  sendQueryInfoMessage = (bfastOrLunchInfo, numStations, cafeInfo, itemToEat, msg) ->
    #Step thru all of the stations at the cafe
    for j in [0...numStations]
      stationInfo = bfastOrLunchInfo[j]
      stationName = bfastOrLunchInfo[j].label
      locationOfItemInStation = stationName.indexOf itemToEat, 0
      #checks for a match in the station name itself. May be useless...
      # if locationOfItemInStation != -1
      #   textToSend = textToSend + "\nFound a match in the " + stationName + " station name"
      matchedStation = stationName
      numItemsAtStation = stationInfo.items.length
      #Step thru all of the items at the station
      for k in [0...numItemsAtStation]
        itemNumber = stationInfo.items[k]
        singleItem = cafeInfo.items[itemNumber]
        itemPrice = singleItem.price
        itemCals = singleItem.nutrition.kcal
        itemName = singleItem.label
        locationOfItemInStationItem = itemName.indexOf itemToEat, 0
        #special case
        if locationOfItemInStationItem != -1
          if count == 0
            textToSend = textToSend + "\n\nThere are matches at the " + stationName.toUpperCase() + " station"
            count = 1
          if itemCals != ""
            textToSend = textToSend + "\n***Matched item: " + itemName + " for " + itemPrice + " with " + itemCals + " calories"
          if itemCals == ""
            textToSend = textToSend + "\n***Matched item: " + itemName + " for " + itemPrice
      count = 0
    msg.send textToSend
    textToSend = ""
