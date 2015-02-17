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

module.exports = (robot) ->
  robot.respond /(reddit|distract) me/i, (msg) ->
      reddit msg
  robot.respond /(reddit|distract) bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    for num in [count..1]
      reddit msg

reddit = (msg) ->
  url = "http://www.reddit.com/top.json"
  msg
    .http(url)
      .get() (err, res, body) ->
        posts = JSON.parse(body)
        if posts.error?
          msg.send "Something went wrong... @MattRick reddited too hard? [http response #{posts.error}]"
          return
        post = getPost(posts)
        if post.domain == 'i.imgur.com'
          msg.send "#{post.title} - http://www.reddit.com#{post.permalink}"
          msg.send post.url
        else
          msg.send "#{post.title} - #{post.url} - http://www.reddit.com#{post.permalink}"

getPost = (posts) ->
  random = Math.round(Math.random() * posts.data.children.length)
  posts.data.children[random]?.data
