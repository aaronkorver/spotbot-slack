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
#
# Author:
#   Kevin Behrens

#TODO make these configurable per room
bombThreshold = 10
hardCoreRedditor = "Matt Rick"

module.exports = (robot) ->
  robot.respond /(reddit|distract) me/i, (msg) ->
    reddit msg
  robot.respond /(reddit|distract) bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    if count > bombThreshold
      msg.send "Seriously!? #{count}!?  #{hardCoreRedditor} would get no work done. Request denied."
      return
    for num in [count..1]
      reddit msg

reddit = (msg) ->
  url = "http://www.reddit.com/top.json"
  msg
    .http(url)
      .get() (err, res, body) ->
        posts = JSON.parse(body)
        post = getPost(posts)
        if post.error?
          msg.send "Something went wrong... #{hardCoreRedditor} reddited too hard? [http response #{posts.error}]"
          return
        if post.over_18 == true
          msg.send "Spotbot has saved you from a NSFW reddit post! If you want to know what it was ask #{hardCoreRedditor} (he's likely already seen it)"
          return
        if post.url.match('(.png|.gif|.jp[eg]|.bmp)') or post.domain.match('(gfycat.com|imgur.com|livememe.com|memedad.com)')
          msg.send post.title
          msg.send post.url
        else
          msg.send "#{post.title} - #{post.url}"

getPost = (posts) ->
  random = Math.round(Math.random() * posts.data.children.length)
  posts.data.children[random]?.data
