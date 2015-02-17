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
hardCoreRedditor = "@MattRick"
bombThreshold = 10

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
        if posts.error?
          msg.send "Something went wrong... #{hardCoreRedditor} reddited too hard? [http response #{posts.error}]"
          return
        if posts.over_18?
          msg.send "Spotbot has saved you from a NSFW reddit post! If you want to know what it was ask #{hardCoreRedditor} (he's likely already seen it)"
          return
        post = getPost(posts)
        if post.domain.match '(gfycat.com|imgur.com|livememe.com|memedad.com)'
          msg.send "#{post.title} - http://www.reddit.com#{post.permalink}"
          msg.send post.url
        else
          msg.send "#{post.title} - #{post.url} - http://www.reddit.com#{post.permalink}"

getPost = (posts) ->
  random = Math.round(Math.random() * posts.data.children.length)
  posts.data.children[random]?.data
