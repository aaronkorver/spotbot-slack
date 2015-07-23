# Description:
#   Creates a meme on img flip and posts the newly created meme to chat
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot meme me <meme> : <top text> / <bottom text> - generates a meme
#   hubot meme list - lists aliased meme templates
#   hubot [top|bottom [n]] memes used - lists the most used meme templates
#
# Author:
#   mrick

Util = require "util"

String::strip = -> if String::trim? then @trim() else @replace /^\s+|\s+$/g, ""

username = "spotbot"
password = "Like4Rock"

# Keep this in order, or I will find you
memeIds = {
    "aliens" :    {"id" : 101470,   "usage" : "Not saying it was aliens / but ALIENS"}
    "archer" :    {"id" : 10628640, "usage" : "Do you want x / because that's how you get x"}
    "boromir" :   {"id" : 61579,    "usage" : "One does not simply / misuse this meme"}
    "brace" :     {"id" : 61546,    "usage" : "Brace yourself / Game of Thrones references are coming"}
    "brian" :     {"id" : 61585,    "usage" : "Uses this meme / dies"}
    "drkev" :     {"id" : 41050220, "usage" : "Dr. Kev says / X"}
    "fry" :       {"id" : 61520,    "usage" : "Not sure if X / or Y"}
    "hindsight" : {"id" : 101708,   "usage" : "If you didn't want x / why did you directly cause x?"}
    "marvin" :    {"id" : 21807506, "usage" : "Holding food and wrapper / threw out food, ate wrapper"}
    "picard" :    {"id" : 245898,   "usage" : "Why the heck / are you not using this meme?"}
    "sohappy":    {"id" : 6781963,  "usage" : "I would be so happy / If you used this meme correctly"}
    "sohot" :     {"id" : 21604248, "usage" : "Zoolander / so hot right now"}
    "success" :   {"id" : 61544,    "usage" : "Brag about doing something"}
    "wonka" :     {"id" : 61582,    "usage" : "Memes are so hard / please tell me all about it"}
    "yuno" :      {"id" : 61527,    "usage" : "Y U NO / speak only in memes?"}
    "xx" :        {"id" : 61532,    "usage" : "I don't always x / but when I do, I y"}
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

  robot.respond /((top|bottom)( \d+)? )?memes used/i, (msg) ->

    asc = true
    amount = 5

    if msg.match[2]
      asc = ("#{msg.match[2]}".trim() is "top")

    if msg.match[3]
      amount = "#{msg.match[3]}".trim()

    memeUses = memeUsageStorage.getMemesUsed(msg, asc, amount)
    memes = []

    if memeUses
      for tally in memeUses
        memes.push "#{tally.memeId} has been used #{tally.count} times in this room"
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

    topText = encodeURIComponent(msg.match[3].strip())
    bottomText = encodeURIComponent(msg.match[4].strip())

    memeUsageStorage.memeUsed(msg, templateName)

    url = "https://api.imgflip.com/caption_image?username=#{username}&password=#{password}&template_id=#{template}&text0=#{topText}&text1=#{bottomText}"

    msg
      .http(url)
        .get() (err, res, body) ->
          if err
            msg.send "Encountered an error: #{err}"
            return

          msg.send JSON.parse(body)["data"]["url"]
