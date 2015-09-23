# Description:
#   Distracts a user with a random reddit front page article
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot [reddit|distract] me - Get a random post from the reddit front page.
#   hubot [reddit|distract] bomb <N> - Get N random posts from the reddit front page.
#   hubot reddit set redditor <N> - Sets the "hardcore" redditor for the room.
#   hubot reddit set limit <N> - Sets the maximum number of results bomb can produce.
#
# Author:
#   Kevin Behrens

bombThreshold = 10
hardCoreRedditor = "Matt Rick"
redditStorage = undefined

module.exports = (robot) ->

  redditStorage = new RedditStorage robot

  robot.respond /(reddit|distract) me/i, (msg) ->
    reddit msg
  robot.respond /(reddit|distract) bomb( (\d+))?/i, (msg) ->
    room = msg.message.user.room
    roomRedditor = redditStorage.getHardCoreRedditor(room) || hardCoreRedditor
    roomThreshold = redditStorage.getBombThreshold(room) || bombThreshold
    count = msg.match[3] || 5
    if count > roomThreshold
      msg.send "Seriously!? #{count}!?  #{roomRedditor} would get no work done. Request denied."
      return
    for num in [count..1]
      reddit msg
  robot.respond /reddit set redditor (.*)/i, (msg) ->
    room = msg.message.user.room
    redditStorage.setHardCoreRedditor(room, msg.match[1])
    msg.send "Set redditor to #{redditStorage.getHardCoreRedditor(room)}"
  robot.respond /reddit set (bomb )?limit (\d+)/i, (msg) ->
    room = msg.message.user.room
    redditStorage.setBombThreshold(room, msg.match[2])
    msg.send "Set bomb limit to #{redditStorage.getBombThreshold(room)}"

reddit = (msg) ->
  url = "http://www.reddit.com/top.json"
  msg
    .http(url)
      .get() (err, res, body) ->
        posts = JSON.parse(body)
        post = getPost(posts)
        room = msg.message.user.room
        if post.error?
          msg.send "Something went wrong... #{redditStorage.getHardCoreRedditor(room)} reddited too hard? [http response #{posts.error}]"
          return
        if post.over_18 == true
          msg.send "Spotbot has saved you from a NSFW reddit post! If you want to know what it was ask #{redditStorage.getHardCoreRedditor(room)} (he's likely already seen it)"
          return
        if post.url.match('(.png|.gif|.jp[eg]|.bmp)') or post.domain.match('(gfycat.com|imgur.com|livememe.com|memedad.com)')
          msg.send post.title
          msg.send post.url
        else
          msg.send "#{post.title} - #{post.url}"

getPost = (posts) ->
  random = Math.round(Math.random() * posts.data.children.length)
  posts.data.children[random]?.data

class RedditStorage
  constructor: (@robot) ->
    @roomData = {}
    @robot.brain.on 'loaded', =>
      roomData = @robot.brain.data.reddit || {}

  getBombThreshold: (room) ->
    threshold = undefined
    if @roomData[room]?
      threshold = @roomData[room]['bombThreshold']
    threshold

  setBombThreshold: (room, threshold) ->
    if ! @roomData[room]?
      @roomData[room] = {}
    @roomData[room]['bombThreshold'] = threshold
    @robot.brain.data.reddit = @roomData

  getHardCoreRedditor: (room) ->
    redditor = undefined
    if @roomData[room]?
      redditor = @roomData[room]['hardCoreRedditor']
    redditor

  setHardCoreRedditor: (room, redditor) ->
    if ! @roomData[room]?
      @roomData[room] = {}
    @roomData[room]['hardCoreRedditor'] = redditor
    @robot.brain.data.reddit = @roomData
