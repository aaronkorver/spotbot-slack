# Description:
#   Responds to pokedex queries and returns relevant data, using http://pokeapi.co
#
# Configuration:
#   none
#
# Commands:
#   hubot pokedex <pokemon name/#> - Searches pokeapi for the pokemon in question and returns basic information
#   hubot pokedex <pokemon name/#> =<option> - specifies options for query result
#   hubot pokedex =options - hubot returns a list of usable options
#
#
# Author:
#   David Boullion
#

## If you are going to add to or modify the functionality of this script,
## the api documentation is at this url: https://pokeapi.co/docsv2/

# FUNCTIONS
#
formatForDisplay = (nameString) ->
  #converts 'string' to 'String', and 'word-three(-string)' to 'Three Word String'
  nonDisplayPattern = /(\w+)-(\w+)-?(\w+|)/i
  returnString = nameString

  #format 2 or 3 word input
  if nonDisplayPattern.test(nameString)
    [tempTempName, tempMegaType, tempMegaVariant] = nameString.match(nonDisplayPattern)[1..3]
    if tempMegaVariant and tempMegaVariant isnt ''
      returnString = "#{tempMegaType} #{tempTempName} #{tempMegaVariant}"
    else
      returnString = "#{tempMegaType} #{tempTempName}"

  #Capitalize
  returnString = returnString.replace /(\w)(\w*)/g, (match, firstLetter, restOfWord) ->
    "#{firstLetter.toUpperCase()}#{restOfWord.toLowerCase()}"

  return returnString

#

addHelpText = (commands, commandDescription) ->
  helpLine = "\n\n"
  if commands.length and commands.length > 0
    helpLine += (" =" + command for command in commands)
  return helpLine + "\n-- #{commandDescription}"

# END OF FUNCTIONS
#
#
# ROBOT COMMANDS

module.exports = (robot) ->
  #options query
  robot.respond /pokedex =options/i, (msg) ->
    #build string and return!
    helpString = "Pokedex option settings:\n" +
    "one option may currently be specified by using a '=' character and then typing the option(s) after the pokemon name."
    helpString = helpString + addHelpText(["detail","d","extreme detail","ed"],
    "specifies general levels of detail to show in query result (default is basic)")
    helpString = helpString + addHelpText(["all sprites","as","shiny","s","male","m","female","fem","f","no sprites","ns"],
    "specifies the sprite(s) to show in basic query results")
    msg.send helpString

  #Pokemon Query
  robot.respond /pokedex (\w+ \w+ \w+|\w+ \w+|\w+) ?=?(\w+|)/i, (msg) ->
    # read query option(s), if they exist.
    optionWords = msg.match[2]
    if optionWords isnt ""
      #read options and set variables
      msg.send "here be options"
    else
      #default query settings
      msg.send "lol no options"

    # QUERY ERROR CHECKING
    # prepare query variable(s)
    nameOrNumber = msg.match[1].toLowerCase()

    # Grab random table; no real way around doing this here, since http calls are asynch;
    # cannot be optional since everything past it must be in the callback,
    # if we want it to happen sequentially (we want it to happen sequentially).
    msg.http("http://pokeapi.co/api/v2/pokemon/\?limit=9000").request() (errRand, resRand, bodyRand) ->
      #check for random
      if nameOrNumber in ['random','rand','r']
        if resRand and resRand.statusCode is 200
          allThePokemon = JSON.parse(bodyRand).results
          allPokemonNames = (aPokemon.name for aPokemon in allThePokemon)
          nameOrNumber = msg.random allPokemonNames
        else
          if resRand
            errorCode = resRand.statusCode
          else
            errorCode = '(No Response)'
          msg.send "Random lookup Failed.\n#{errRand}, Code: #{errorCode}"

      # format spoken mega pokemon names to play nice with pokeapi
      inputPattern = /(\w+) (\w+) ?(\w+|)/i #catches mega|primal pokemonName [XxYy]
      if inputPattern.test(nameOrNumber)
        [megaType, tempName, megaVariant] = nameOrNumber.match(inputPattern)[1..3]
        nameOrNumber = "#{tempName}-#{megaType}"
        if megaVariant and megaVariant isnt ''
          nameOrNumber = nameOrNumber + "-#{megaVariant}"

      # execute query, get JSON data
      msg.http("http://pokeapi.co/api/v2/pokemon/#{nameOrNumber}/").request() (err, res, body) ->
        if body and res and res.statusCode is 200
          pokeData = JSON.parse(body)
          msg.http(pokeData.species.url).request() (errSpec, resSpec, bodySpec) ->
            if bodySpec and resSpec and resSpec.statusCode is 200
              speciesData = JSON.parse(bodySpec)

              #NULL CHECKING
              unless pokeData? and speciesData?
                msg.send "No results in the pokedex for #{nameOrNumber}"
                return

              # OUTPUT PROCESSING
              ## BASIC DATA (always used)
              #-------------name output
              if pokeData.name
                pokeDisplayName = pokeData.name
              else
                pokeDisplayName = nameOrNumber

              #format display name. Should be Capitalized And Spoken Format
              pokeDisplayName = formatForDisplay(pokeDisplayName)

              #-----------grab english genus
              genera = speciesData.genera
              if genera
                englishGenera = (tempGenus.genus for tempGenus in genera when tempGenus.language.name is 'en')
                genus = msg.random englishGenera #just in case there's more than one?
              else
                genus = "???"

              #----------Gender Data
              if speciesData.gender_rate
                genderRate = speciesData.gender_rate
                if genderRate < 0
                  genderRate = -1
                  genderText = "#{pokeDisplayName} is genderless"
                else if genderRate = 0
                  genderText = "Every #{pokeDisplayName} is male"
                else if genderRate >= 8
                  genderRate = 1
                  genderText = "Every #{pokeDisplayName} is female"
                else
                  genderRate = speciesData.gender_rate / 8
                  genderText = "Male: #{(1 - genderRate) * 100}%, Female: #{genderRate * 100}%"
              else
                genderRate = -1
                genderText = "Gender Rate Not Found"

              #--------Sprite prep!
              if pokeData.sprites
                if pokeData.sprites.front_default
                  defSprite = pokeData.sprites.front_default
                if pokeData.sprites.front_shiny
                  defShiny = pokeData.sprites.front_shiny
                if pokeData.sprites.front_female
                  femSprite = pokeData.sprites.front_female
                if pokeData.sprites.front_shiny_female
                  femShiny = pokeData.sprites.front_shiny_female
                #prepare first lines
                #shiny and fem random checks for convenience
                #chance for shiny: 1/8192 - 0.012207031%
                shinyCheck = Math.random() < 0.00012207031
                femCheck = Math.random() < genderRate

                #get first sprite
                spriteLevel = 0 #!!DEBUG!!
                if spriteLevel #user specified sprite output
                  if spriteLevel = 0 #ALL SPRITES
                    if genderRate = 1 #fem only
                      firstSpriteLine = "Female: "
                    else if genderRate < 0 #genderless
                      firstSpriteLine = "Normal: "
                    else
                      firstSpriteLine = "Male: "
                    #show default sprite first
                    firstSpriteLine = firstSpriteLine + defSprite
                  else if spriteLevel = 2 and femSprite #FEMALE SPRIT
                    if shinyCheck and femShiny
                      firstSpriteLine = femShiny
                    else
                      firstSpriteLine = femSprite
                  else if spriteLevel = 3 #SHINY SPRITE
                    if femShiny and femCheck
                      firstSpriteLine = femShiny
                    else
                      firstSpriteLine = defShiny
                  else #MALE SPRITE
                    if shinyCheck and defShiny
                      firstSpriteLine = defShiny
                    else
                      firstSpriteLine = defSprite

                else #default behavior: random
                  if femSprite and femCheck
                    #show female sprite
                    if femShiny and shinyCheck
                      #show shiny female sprite
                      firstSpriteLine = femShiny
                    else
                      firstSpriteLine = femSprite
                  else
                    #show male/default sprite
                    if defShiny and shinyCheck
                      #show shiny male/default sprite
                      firstSpriteLine = defShiny
                    else if defSprite
                      firstSpriteLine = defSprite
                    else
                      firstSpriteLine = "Sprites Not Found"
              else
                firstSpriteLine = "Sprites Not Found"


              #------------select a random ENGLISH pokedex entry #Always used or no?
              pokedexEntries = speciesData.flavor_text_entries
              if pokedexEntries
                #grab all english pokedex Entries
                englishEntries = (tempEntry.flavor_text for tempEntry in pokedexEntries when tempEntry.language.name is 'en')
                if englishEntries and englishEntries.length > 0
                  #random select from english Entries
                  pokedexEntry = msg.random englishEntries
                  pokedexEntry = pokedexEntry.replace /\s+/g, (match) ->
                    " "
                else
                  pokedexEntry = "No Entries Found"
              else
                pokedexEntry = "No Entries Found"

              detailLevel = 2 #DEBUG

              ##NON-BASIC DATA
              #-------------Evolution chain OR pre-evolution
              ###
              # unfortunately, because asynch can be tricky here...
              # I won't implement evolution chain for now; it'll require
              # another http request, making the response time even longer,
              # and another level of indentation, which makes coding more annoying.
              # The callback spaghetti is real.
              # (if anyone knows how I could make these requests reliably parallel
              # and nice to read, please let me know how or change it)
              # Evo chain
               if evoChain = true or detail and detail >= 2
                # get evolution tree and print it
                evoData = "\nEvolution Tree:"
                # evolution chain data is in a nested format in the json at the url:
                #   speciesData.evolution_chain.url
              ###
              # Pre-Evo
              #else if detail and detail >= 1 #if evolution chain was a thing,
              if detailLevel and detailLevel >= 1 #this would be mutually exclusive with evo chain
                # Just get pokemon that evolves into this pokemon, if any.
                if speciesData.evolves_from_species
                  evoData = "\n#{pokeDisplayName} evolves from" +
                  " #{formatForDisplay(speciesData.evolves_from_species.name)}"
                else
                  evoData = "\n#{pokeDisplayName} does not evolve from another pokemon."

              ## DETAIL ONLY
              if detailLevel
                # NORMAL DETAIL (detailLevel >= 1)
                if detailLevel >= 1
                  #-------------Typing
                  pokeType = ""
                  if pokeData.types
                    typeArray = pokeData.types.sort (a,b) ->
                      return if a.slot >= b.slot then 1 else -1
                    pokeType = (" " + formatForDisplay(typeHolder.type.name) for typeHolder in typeArray)

                  #-------------Dimensions
                  #height
                  pokeHeight = pokeData.height / 10
                  #weight
                  pokeWeight = pokeData.weight / 10

                  #-------------Forms...?
                # HIGH DETAIL (detailLevel >= 2)
                if detailLevel >= 2
                  #-------------???
                  detail = 2 #so the interpreter will shut up about POST_IF for now

              # PRINT OUTPUT
              # Send Header Message(s) (basic data + sprite(s)
              msg.send "\##{speciesData.id}: #{pokeDisplayName}, the #{genus} Pokemon.\n" +
              firstSpriteLine
              # if all sprites
              if spriteLevel and spriteLevel = 0
                # show female sprite if exists and can be fem or male
                if femSprite and genderRate isnt 1 and genderRate > 0
                  msg.send "Female: " + femSprite
                # show shiny sprites if extreme detail or shiny
                if defShiny
                  if genderRate = 1 #fem only
                    defShinyText = "Shiny Female: "
                  else if genderRate < 0 #genderless
                    defShinyText = "Shiny: "
                  else
                    defShinyText = "Shiny Male: "
                  msg.send defShinyText + defShiny
                # show shiny fem sprite if exists and can be fem or male
                if femShiny and genderRate isnt 1 and genderRate > 0
                  msg.send "Shiny Female: " + femShiny

              #BUILD BODY MESSAGE THEN SEND
              bodyMessage = "Today's Pokedex Entry:\n#{pokedexEntry}\n"

              #EVOLUTION CHAIN OR PRE EVOLUTION
              if evoData
                bodyMessage += evoData

              #OTHER DATA
              bodyMessage += "\nType:#{pokeType}"

              #DETAIL ONLY
              if detailLevel
                if detailLevel >= 1
                  #dimensions
                  bodyMessage += "\nHeight: #{pokeHeight} m"
                  bodyMessage += "\nWeight: #{pokeWeight} kg"
                  #gender
                  bodyMessage += "\nGender Rate: #{genderText}"
                #EXTREME DETAIL ONLY
                if detailLevel >= 2
                  #forms
                  detailLevel = 2 #shut up about POST_IF plz



              #!Send body message!
              msg.send bodyMessage

            else #HTTP REQUEST ERROR CATCHING (speciesData)
              if resSpec
                errorCode = resSpec.statusCode
              else
                errorCode = '(No Response)'
              msg.send "Cannot find pokedex!\n#{errSpec}, Code: #{errorCode}"
        else ##HTTP REQUEST ERROR CATCHING (pokeData)
          if res
            errorCode = res.statusCode
          else
            errorCode = '(No Response)'
          msg.send "Cannot find pokedex!\n#{err}, Code: #{errorCode}"
