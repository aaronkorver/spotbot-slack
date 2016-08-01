# Description:
#   Responds to pokedex queries and returns relevant data, using http://pokeapi.co
#
# Configuration:
#   none
#
# Commands:
#   hubot (pokedex|pd) <pokemon name|#> - gets pokedex information for the pokemon
#   hubot (pokedex|pd) <pokemon name|#> -<option> - specifies options for query result
#   hubot (pokedex|pd) random -<option> - find a random pokemon
#   hubot (pokedex|pd) -options - Returns a list of options usable with pokedex
#
#
# Author:
#   David Boullion
#

## If you are going to add to or modify the functionality of this script,
## the api documentation is at this url: https://pokeapi.co/docsv2/


# FUNCTIONS
#
capitalizeWord = (inputString) ->
  if not inputString
    return
  returnString = inputString.replace /(\w)(\w*)/g, (match, firstLetter, restOfWord) ->
    "#{firstLetter.toUpperCase()}#{restOfWord.toLowerCase()}"
  return returnString

#

formatDisplayNameForQuery = (nameOrNumber) ->
  if not nameOrNumber
    return

  returnString = nameOrNumber.toLowerCase()
  # format spoken mega pokemon names to play nice with pokeapi
  # with exceptions accounted for.
  inputPattern = /(\w+) (\w+) ?(\w+|)/i #catches mega|primal pokemonName [XxYy]
  if inputPattern.test(returnString)
    [megaType, tempName, megaVariant] = returnString.match(inputPattern)[1..3]
    returnString = "#{tempName}-#{megaType}"
    if megaVariant? and megaVariant isnt ''
      if tempName in ["star","striped"] #gosh darned cosplay pikachus and basculin
        returnString = "#{megaVariant}-#{megaType}-#{tempName}"
      else
        returnString += "-#{megaVariant}"
    else if tempName is "mime" or megaType is "mime" #gosh darned mimes
      returnString = "#{megaType}-#{tempName}"
  else if returnString is "meowstic" #gosh darned meowstic
    if Math.random() < 0.5
      returnString = "meowstic-male"
    else
      returnString = "meowstic-female"
  else if returnString is "nidoran" #gosh darned nidoran
    if Math.random() < 0.5
      returnString = "nidoran-m"
    else
      returnString = "nidoran-f"
  else if returnString is "wormadam" #gosh darned wormadam
    randomChance = Math.random()
    if randomChance < 0.33
      returnString = "wormadam-plant"
    else if randomChance < 0.66
      returnString = "wormadam-sandy"
    else
      returnString = "wormadam-trash"
  else if returnString is "giratina" #gosh darned giratina
    returnString = "giratina-altered"
  else if returnString is "farfetch'd" #gosh darned Farfetch'd
    returnString = "farfetchd"
  else if returnString is "deoxys" #gosh darned deoxys
    returnString = "deoxys-normal"
  else if returnString is "shaymin" #gosh darned shaymin
    returnString = "shaymin-land"
  else if returnString is "basculin" #goshed darned basculin
    if Math.random() < 0.5
      returnString = "basculin-red-striped"
    else
      returnString = "basculin-blue-striped"
  else if returnString is "darmanitan" #gosh darned darmanitan
    returnString = "darmanitan-standard"
  else if returnString in ["tornadus","thundurus","landorus"] #gosh darned genie trio
    returnString += "-incarnate"
  else if returnString is "keldeo" #gosh darned water pony
    returnString = "keldeo-ordinary"
  else if returnString is "meloetta" #goshed darned meloetta
    if Math.random() < 0.5
      returnString = "meloetta-aria"
    else
      returnString = "meloetta-pirouette"
  else if returnString is "aegislash" #goshed darned aegislash
    if Math.random() < 0.5
      returnString = "aegislash-blade"
    else
      returnString = "aegislash-shield"
  else if returnString in ["gourgeist","pumpkaboo"] #gosh darned pumpkins
    randomChance = Math.random()
    if randomChance < 0.25
      returnString += "-small"
    else if randomChance < 0.5
      returnString += "-average"
    else if randomChance < 0.75
      returnString += "-large"
    else
      returnString += "-super"
  return returnString

#

formatNameForDisplay = (nameString) ->
  if not nameString
    return
  # converts 'string' to 'String', and 'word-three(-string)' to 'Three Word String'
  # except for exceptions.
  nonDisplayPattern = /(\w+)-(\w+)-?(\w+|)/i
  returnString = nameString.toLowerCase()
  #format 2 or 3 word input
  if nonDisplayPattern.test(returnString)
    [tempTempName, tempMegaType, tempMegaVariant] = returnString.match(nonDisplayPattern)[1..3]
    if tempMegaVariant and tempMegaVariant isnt ''
      if tempMegaVariant in ["star","striped"] #gosh darned cosplay pikachus
        returnString = "#{tempMegaType} #{tempMegaVariant} #{tempTempName}"
      else
        returnString = "#{tempMegaType} #{tempTempName} #{tempMegaVariant}"
    else if tempTempName is "mime" or tempMegaType is "mime" #gosh darned mimes
      returnString = "#{tempTempName} #{tempMegaType}"
    else if tempTempName in ["porygon","ho"] and tempMegaType in ["z","oh"] #gosh darned porygons and ho-ohs
      returnString = "#{tempTempName}-#{tempMegaType}"
    else
      returnString = "#{tempMegaType} #{tempTempName}"

  #Capitalize
  returnString = capitalizeWord(returnString)

  if returnString is "Farfetchd" #gosh darned Farfetch'd
    returnString = "Farfetch'd"
  else if returnString is "Normal Deoxys" #gosh darned Deoxys
    returnString = "Deoxys"
  else if returnString is "Standard Darmanitan" #is this really necessary, darmanitan?
    returnString = "Darmanitan"
  else if returnString is "Ordinary Keldeo" #all aboard the unneccesary standard form name train
    returnString = "Keldeo"
  return returnString

#

formatTextForDisplay = (inputString) ->
  if not inputString
    return
  #capitalizes and replaces - with space
  #replace - with ' '
  returnString = inputString.replace /-/g, (match) ->
    " "
  #Capitalize
  returnString = capitalizeWord(returnString)

  return returnString

#

addHelpText = (commands, commandDescription) ->
  helpLine = "\n\n"
  if commands.length and commands.length > 0
    helpLine += (" -" + command for command in commands)
  return helpLine + "\n== #{commandDescription}"

# END OF FUNCTIONS
#

#
# ROBOT COMMANDS

module.exports = (robot) ->
  # set up pokemon list
  pokedexList = null
  robot.http("http://pokeapi.co/api/v2/pokemon/\?limit=9001").request() (err, res, body) ->
    if res and res.statusCode is 200
      allThePokemon = JSON.parse(body).results
      pokedexList = (aPokemon.name for aPokemon in allThePokemon)

  #options query
  robot.respond /(pokedex|pd) -options/i, (msg) ->
    #build string and return!
    helpString = "Pokedex option settings:\n" +
    "one option may currently be specified by using a '-' character and then typing the option(s) after the pokemon name."
    helpString = helpString + addHelpText(["detail","d"],
    "enable to return more data in query response")
    helpString = helpString + addHelpText(["all sprites","as","shiny","s","male","m","female","fem","f","no sprites","ns"],
    "specifies the sprite(s) to show in basic query results")
    msg.send helpString

  #Pokemon Query
  robot.respond /(pokedex|pd) (\w+[ -]\w+[ -]\w+|\w+[' -]\w+|\w+)( -)?(\w+|)/i, (msg) ->
    #default query settings
    detailLevel = 0 #lower detail
    spriteLevel = 1 #random sprite
    # read query option(s), if they exist.
    optionWords = msg.match[4]
    if optionWords isnt ""
      #read option and set variables
      #detail level
      if optionWords in ["detail","d"]#higher detail
        detailLevel = 1

      #sprites shown
      if optionWords in ["no sprites","ns"]# no sprites
        spriteLevel = 0
      else if optionWords in ["male","m"]# a male sprite
        spriteLevel = 2
      else if optionWords in ["female","fem","f"]# a fem sprite
        spriteLevel = 3
      else if optionWords in ["shiny","s"]# a shiny sprite
        spriteLevel = 4
      else if optionWords in ["all sprites","as"]# all sprites
        spriteLevel = 5

    # QUERY ERROR CHECKING
    # prepare query variable(s)
    nameOrNumber = msg.match[2].toLowerCase()

    # if random, select a random pokemon from pokedexList
    if nameOrNumber in ['random','rand','r']
      if pokedexList
        nameOrNumber = msg.random pokedexList
      else
        msg.send "Random lookup Failed."

    # format spoken mega pokemon names to play nice with pokeapi
    nameOrNumber = formatDisplayNameForQuery(nameOrNumber)

    # execute query, get JSON data
    msg.http("http://pokeapi.co/api/v2/pokemon/#{nameOrNumber}/").request() (err, res, body) ->
      if not body or not res or res.statusCode isnt 200
        ##HTTP REQUEST ERROR CATCHING (pokeData)
        #if res
        #  errorCode = res.statusCode
        #else
        #  errorCode = '(No Response)'
        msg.send "Sorry, I cannot find #{formatNameForDisplay(nameOrNumber)} in the pokedex!"
        #msg.send "\n#{err}, Code: #{errorCode}"
        return
      #otherwise, next query
      pokeData = JSON.parse(body)

      msg.http(pokeData.species.url).request() (errSpec, resSpec, bodySpec) ->
        if not bodySpec or not resSpec or resSpec.statusCode isnt 200
          #HTTP REQUEST ERROR CATCHING (speciesData)
          #if resSpec
          #  errorCode = resSpec.statusCode
          #else
          #  errorCode = '(No Response)'
          msg.send "Sorry, I cannot find #{formatNameForDisplay(nameOrNumber)} in the pokedex!"
          #msg.send "\n#{err}, Code: #{errorCode}"
          return

        #no http errors, move onwards.
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
        pokeDisplayName = formatNameForDisplay(pokeDisplayName)

        #-----------grab english genus
        genera = speciesData.genera
        if genera
          englishGenera = (tempGenus.genus for tempGenus in genera when tempGenus.language.name is 'en')
          genus = msg.random englishGenera #just in case there's more than one?
        else
          genus = "???"

        #----------Gender Data
        if speciesData.gender_rate isnt null
          genderRate = speciesData.gender_rate
          if genderRate < 0
            genderRate = -1
            genderText = "#{pokeDisplayName} is genderless"
          else if genderRate is 0
            genderText = "Every #{pokeDisplayName} is male"
          else if genderRate >= 8
            genderRate = 1
            genderText = "Every #{pokeDisplayName} is female"
          else
            genderRate = speciesData.gender_rate / 8
            genderText = "Male: #{(1 - genderRate) * 100}%, Female: #{genderRate * 100}%"
        else
          genderRate = -1
          genderText = "Gender Ratio Not Found"

        #--------Sprite prep!
        #if spriteLevel is 0, no sprites.
        if pokeData.sprites and spriteLevel
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
          if /male meowstic/i.test(pokeDisplayName)#gosh darned meowstic
            femCheck = false
          else if /female meowstic/i.test(pokeDisplayName)
            femCheck = true

          #get first sprite
          if spriteLevel isnt 1 #user specified sprite output
            if spriteLevel is 5 #ALL SPRITES
              if genderRate is 1 #fem only
                firstSpriteLine = "Female: "
              else if genderRate isnt 0 #genderless or only def
                firstSpriteLine = "Normal: "
              else
                firstSpriteLine = "Male: "
                #show default/male sprite first
              firstSpriteLine = firstSpriteLine + defSprite
            else if spriteLevel is 3 and femSprite #FEMALE SPRIT
              if shinyCheck and femShiny
                firstSpriteLine = femShiny
              else
                firstSpriteLine = femSprite
            else if spriteLevel is 4 #SHINY SPRITE
              if femShiny and femCheck
                firstSpriteLine = femShiny
              else
                firstSpriteLine = defShiny
            else #MALE SPRITE; 'assigned' to spriteLevel = 2
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
          firstSpriteLine = ""

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
            pokedexEntry = pokedexEntry.replace /([­-] | [­-])/g, (match) ->
              " "
          else
            pokedexEntry = "No Entries Found"
        else
          pokedexEntry = "No Entries Found"


        ##NON-BASIC DATA
        #-------------Evolution chain OR pre-evolution
        ###
        # unfortunately, because asynch can be tricky here...
        # I won't implement evolution chain for now; it'll require
        # another asynch http request, making the response time even longer,
        # and another level of indentation, which makes formatting my
        # code correctly more annoying.
        # (if anyone knows how I could make these asynch requests reliably
        # parallel and nice to read, please let me know how or change it)
        # Evo chain
         if evoChain = true or detail and detail >= 1
          # get evolution tree and print it
          evoData = "\nEvolution Tree:"
          # evolution chain data is in a nested format in the json at the url:
          #   speciesData.evolution_chain.url
        ###
        # Pre-Evo
        #else if speciesData.evolves_from_species #if evolution chain was a thing, this would
        # be mutually exclusive with evo chain
        # Just get pokemon that evolves into this pokemon, if any.
        if speciesData.evolves_from_species
          evoData = "\n#{pokeDisplayName} evolves from" +
          " #{formatNameForDisplay(speciesData.evolves_from_species.name)}"
        else
          evoData = "\n#{pokeDisplayName} does not evolve from another pokemon."

        #-------------Typing
        pokeType = ""
        if pokeData.types
          typeArray = pokeData.types.sort (a,b) ->
            return if a.slot >= b.slot then 1 else -1
          pokeType = (" " + formatTextForDisplay(typeHolder.type.name) for typeHolder in typeArray)

        #-------------Abilities
        abilityText = ""
        if pokeData.abilities
          abilityArray = pokeData.abilities.sort (a,b) ->
            return if a.slot >= b.slot then 1 else -1
          abilities = (" " + formatTextForDisplay(ability.ability.name) for ability in abilityArray when ability.is_hidden is false)
          hiddenAbilities = (" " + formatTextForDisplay(ability.ability.name) for ability in abilityArray when ability.is_hidden is true)
          if abilities.length > 1
            abilityText = "\nAbilities:#{abilities}"
          else
            abilityText = "\nAbility:#{abilities}"
          if hiddenAbilities and hiddenAbilities.length > 0
            if hiddenAbilities.length > 1
              abilityText += "\n Hidden Abilities:#{hiddenAbilities}"
            else
              abilityText += "\n Hidden Ability:#{hiddenAbilities}"


        ## DETAIL ONLY
        if detailLevel
          # NORMAL DETAIL (detailLevel >= 1)
          if detailLevel >= 1
            #-------------Dimensions
            #height
            pokeHeight = pokeData.height / 10
            #weight
            pokeWeight = pokeData.weight / 10

            #-------------Base Stats and Effort Points
            baseStatArray = pokeData.stats
            baseStats = (" " + formatTextForDisplay(baseStat.stat.name) +
            ": " + baseStat.base_stat for baseStat in baseStatArray)

            effortPoints = (" " + formatTextForDisplay(baseStat.stat.name) +
            ": " + baseStat.effort for baseStat in baseStatArray when baseStat.effort > 0)

            #-------------Forms
            forms = speciesData.varieties
            if forms
              pokeForms = (" " + formatNameForDisplay(form.pokemon.name) for form in forms)

            #-------------Egg Group(s)
            if speciesData.egg_groups
              eggGroups = (" " + formatTextForDisplay(eggGroup.name) for eggGroup in speciesData.egg_groups)
              if eggGroups[0] is " No Eggs"
                eggInfo = "\n#{pokeDisplayName} cannot breed"
              else if genderRate < 0
                eggInfo = "\n#{pokeDisplayName} can only breed with a Ditto"
              else
                eggInfo = "\nEgg Groups:#{eggGroups}"
            else
              eggInfo = "\nEgg Groups not found"


        # PRINT OUTPUT
        # Send Header Message(s) (basic data + sprite(s)
        msg.send "(catchemall) \##{speciesData.id}: #{pokeDisplayName}, the #{genus} Pokemon.\n" +
        firstSpriteLine
        # if all sprites
        if spriteLevel and spriteLevel is 5
          # show female sprite if exists and can be fem or male
          if femSprite and genderRate isnt 1 and genderRate > 0
            msg.send "Female: " + femSprite
          # show shiny sprites
          if defShiny
            if genderRate is 1 #fem only
              defShinyText = "Shiny Female: "
            else if genderRate isnt 0 #genderless or def only
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
        bodyMessage += evoData

        #OTHER DATA
        #type(s)
        bodyMessage += "\nType:#{pokeType}"
        #Abilities
        bodyMessage += abilityText

        #DETAIL ONLY
        if detailLevel
          if detailLevel >= 1
            #dimensions
            bodyMessage += "\nHeight: #{pokeHeight} m" +
            "\nWeight: #{pokeWeight} kg"
            #gender
            bodyMessage += "\nGender Ratio: #{genderText}"
            #egg groups
            bodyMessage += eggInfo
            #stats
            bodyMessage += "\nBase Stats:\n#{baseStats}" +
            "\nEffort Points yielded from defeating #{pokeDisplayName}:\n#{effortPoints}"
            #forms
            if pokeForms and pokeForms.length > 1
              bodyMessage += "\nAlternate Forms:#{pokeForms}"
            else
              bodyMessage += "\n#{pokeDisplayName} has no alternate forms."




        #!Send body message!
        msg.send bodyMessage
