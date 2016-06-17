# Description:
#   Responds to pokedex queries and returns relevant data, using http://pokeapi.co
#
# Configuration:
#   none
#
# Commands:
#   hubot pokedex [me] <query> - Searches YouTube for the query and returns the video link.
#
# Author:
#   David Boullion
#


formatForDisplay = (nameString) ->
  #converts 'string' to 'String', and 'word-three(-string)' to 'Three Word String'
  #this doesn't work yet.
  nonDisplayPattern = ///
      (\w+)-(\w+)-?(\w+|)/i
  ///
  returnString = nameString

  #format 2 or 3 word input
  if nonDisplayPattern.test(nameString)
    [tempTempName, tempMegaType, tempMegaVariant] = nameString.match(nonDisplayPattern)[1..3]
    if tempMegaVariant and tempMegaVariant isnt ''
      returnString = "#{tempMegaType} #{tempTempName} #{tempMegaVariant}"
    else
      returnString = "#{tempMegaType} #{tempTempName}"

  #Capitalize
  returnString.replace /(\w)(\w*)/g, (firstLetter, restOfWord) ->
    "#{firstLetter.toUpperCase()}#{restOfWord.toLowerCase()}"
  return returnString


module.exports = (robot) ->

  #Pokemon Query
  robot.respond /pokedex (primal \w+|mega \w+ [XxYy]|mega \w+|\w+)( evolutions| moves| detail| extreme detail|)/i, (msg) ->
    # QUERY ERROR CHECKING
    # prepare query variable(s)
    msg.send msg.match[1] #!!DEBUG!!
    nameOrNumber = msg.match[1].toLowerCase()
    msg.send nameOrNumber #!!DEBUG!!

    # format spoken mega pokemon names to play nice with pokeapi
    inputPattern = ///
        (\w+) (\w+) ?(\w+|)/i #catches mega|primal pokemonName [XxYy]
    ///
    if inputPattern.test(nameOrNumber)
      [megaType, tempName, megaVariant] = nameOrNumber.match(inputPattern)[1..3]
      nameOrNumber = "#{tempName}-#{megaType}"
      if megaVariant and megaVariant isnt ''
        nameOrNumber = "#{nameOrNumber}-#{megaVariant}"
    msg.send nameOrNumber #!!DEBUG!!

    msg.send formatForDisplay(nameOrNumber) #!!DEBUG!!

    # execute query, get JSON data
    msg.send("http://pokeapi.co/api/v2/pokemon/#{nameOrNumber}") #!!DEBUG!!
    msg.http("http://pokeapi.co/api/v2/pokemon/#{nameOrNumber}")
      .get() (err, res, body) ->
        msg.send err
        msg.send res.statusCode #this is usually 301
        msg.send res.loc
        #I've been told that the redirect url is in the 'location' in the
        #response, but I've not found the name of that variable
        msg.send body
        if res.statusCode is 200
          pokeData = JSON.parse(body)

        #NULL CHECKING
        unless pokeData?
          msg.send "No results in the pokedex for #{nameOrNumber}"
          return

        #OUTPUT PROCESSING
        #name and sprite output (separate message from rest of data)
        if pokeData.name
          pokeDisplayName = pokeData.name
        else
          pokeDisplayName = nameOrNumber
        #format display name. Should be Capitalized And Spoken Format
        formatForDisplay(pokeDisplayName)

        msg.send "\##{pokeDisplayName}\n"
