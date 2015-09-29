# Description:
#   Creates a meme on img flip and posts the newly created meme to chat
#
# Dependencies:
#   None
#
# Commands:
#   hubot meme me <meme> : <top text> / <bottom text> - generates a meme
#   hubot meme list - lists aliased meme templates
#   hubot [top|bottom [n]] memes used [global] - lists the most used meme templates
#
# Author:
#   mrick

Util = require "util"
createMeme = require('./lib/img-flip')

String::strip = -> if String::trim? then @trim() else @replace /^\s+|\s+$/g, ""

# Keep this in order, or I will find you
memeIds = {
    "aliens" :    {"id" : 101470,   "usage" : "Not saying it was aliens / but ALIENS"}
    "allthings" : {"id" : 61533,    "usage" : "X / all of the Y"}
    "archer" :    {"id" : 10628640, "usage" : "Do you want X / because that's how you get X"}
    "boromir" :   {"id" : 61579,    "usage" : "One does not simply / misuse this meme"}
    "brace" :     {"id" : 61546,    "usage" : "Brace yourself / Game of Thrones references are coming"}
    "brian" :     {"id" : 61585,    "usage" : "Uses this meme / dies"}
    "drkev" :     {"id" : 41050220, "usage" : "Dr. Kev says / X"}
    "fry" :       {"id" : 61520,    "usage" : "Not sure if X / or Y"}
    "hindsight" : {"id" : 101708,   "usage" : "If you didn't want X / why did you directly cause X?"}
    "madmoney"  : {"id" : 1613953,  "usage" : "1613953 is out / invest in madmoney"}
    "marvin" :    {"id" : 21807506, "usage" : "Holding food and wrapper / threw out food, ate wrapper"}
    "morpheus" :  {"id" : 100947,   "usage" : "What if I told you / you can use this alias now?"}
    "paddlin" :   {"id" : 5265532,  "usage" : "Not using this meme? / That's a paddlin'"}
    "picard" :    {"id" : 245898,   "usage" : "Why the heck / are you not using this meme?"}
    "sohappy" :   {"id" : 6781963,  "usage" : "I would be so happy / If you used this meme correctly"}
    "sohot" :     {"id" : 21604248, "usage" : "Zoolander / so hot right now"}
    "stop" :      {"id" : 27700015, "usage" : "Stop trying to make this meme happen / it's not going to happen"}
    "success" :   {"id" : 61544,    "usage" : "Brag about doing something"}
    "toohigh" :   {"id" : 61580,    "usage" : "X / is too damn high"}
    "wonka" :     {"id" : 61582,    "usage" : "Memes are so hard / please tell me all about it"}
    "yuno" :      {"id" : 61527,    "usage" : "Y U NO / speak only in memes?"}
    "xx" :        {"id" : 61532,    "usage" : "I don't always X / but when I do, I Y"}
  };

class MemeUsageDetails
  constructor: ->
    @count = 0

class MemeUsageStorage
  constructor: (@robot) ->
    @memeUses = {}

    @robot.brain.on 'loaded', =>
        @memeUses = @robot.brain.data.memeUses || {}

  roomStorage : (msg) ->
    room = msg.message.room
    result = @memeUses[room]

    if (!result)
        result = {uses: {}}
        @memeUses[room] = result
    result

  memeUsed : (msg, memeId) ->
    roomUses = @roomStorage(msg)['uses']
    memeUsageDetails = @getMemeUsageDetails(msg, memeId)
    memeUsageDetails.count += 1;
    @save()

  getMemeUsageDetails : (msg, memeId) ->
    memeUsageDetails = @roomStorage(msg)['uses'][memeId]
    if (!memeUsageDetails)
      memeUsageDetails = new MemeUsageDetails()
      @roomStorage(msg)['uses'][memeId] = memeUsageDetails
    memeUsageDetails

  getMemesUsed : (msg, asc, amount) ->
    tally = []

    for memeId, details of @roomStorage(msg)['uses']
      tally.push(memeId: memeId, count: details.count)

    amount = Math.min(amount, tally.length)
    tally.sort((a,b) -> if asc then b.count - a.count else a.count - b.count)
    tally.slice(0, amount)

  globalMemesUsed : (asc, amount) ->
    memes = {}
    tally = []

    for room, roomStorage of @memeUses
      for memeId, details of roomStorage['uses']
        if memes[memeId]?
          memes[memeId] += details.count
        else
          memes[memeId] = details.count

    for memeId, count of memes
      tally.push(memeId: memeId, count: count)

    amount = Math.min(amount, tally.length)
    tally.sort((a,b) -> if asc then b.count - a.count else a.count - b.count)
    tally.slice(0, amount)

  save : ->
      @robot.brain.data.memeUses = @memeUses

module.exports = (robot) ->

  memeUsageStorage = new MemeUsageStorage robot

  robot.respond /meme list/i, (msg) ->
    memeList = []
    memeList.push "Supported memes:"
    for key of memeIds
      memeList.push "    #{key}: #{memeIds[key]["usage"]}"
    msg.send memeList.join("\n")

  robot.respond /((top|bottom)( \d+)? )?memes used( global(ly)?)?/i, (msg) ->

    asc = true
    amount = 5
    global = false
    messageSuffix = "in this room"

    if msg.match[2]
      asc = ("#{msg.match[2]}".trim() is "top")

    if msg.match[3]
      amount = "#{msg.match[3]}".trim()

    if msg.match[4]
      global = "#{msg.match[4]}".trim()?

    if global
      memeUses = memeUsageStorage.globalMemesUsed(asc, amount)
      messageSuffix = "globally"
    else
      memeUses = memeUsageStorage.getMemesUsed(msg, asc, amount)
    memes = []

    if memeUses
      for tally in memeUses
        memes.push "#{tally.memeId} has been used #{tally.count} times #{messageSuffix}"
    else
      msg.send "No meme usage has ever been recorded in this room"

    msg.send memes.join("\n")

  robot.respond /(meme) me (.*):(.*)\/(.*)/i, (msg) ->

    templateName = msg.match[2].strip()

    if ! memeIds[templateName]
      template = templateName
      msg.send "I don't have that meme. Open a pull request to add it."
    else
      template = memeIds[templateName]["id"]

    topText = msg.match[3].strip()
    bottomText = msg.match[4].strip()

    memeUsageStorage.memeUsed(msg, templateName)
    createMeme(msg, template, topText, bottomText)
