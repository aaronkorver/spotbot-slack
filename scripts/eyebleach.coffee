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
#   hubot eyebleach me - Bleaches the eyes
#
# Author:
#   Greg "The Yellow Dart" Case


announcements = [
   "That bad, huh?"
   "We should take away @MattRick's hipchat access"
   "The goggles, they do nothing!"
   "Puppies incoming in 3...2....1"
   "Let me guess... Canned chicken?"
   "Spotbot to the rescue!"
   "You own me an e-beer"
   "Somebody say eyebleach? What could be so bad... oh god it's terrible...  What's wrong with you people?"
]

eyebleachCount = 5


module.exports = (robot) ->
  robot.hear /eye ?bleach/i, (msg) ->
    eyebleach msg

eyebleach = (msg) ->
  url = "http://www.reddit.com/r/eyebleach.json"
  msg.send(msg.random announcements)

  msg
    .http(url)
      .get() (err, res, body) ->
        posts = JSON.parse(body)
        if posts.error?
          msg.send "Something went wrong... [http response #{posts.error}]"
          return

        items = posts.data.children
        shuffle(items)
        num = 0
        idx = 0
        while (num < eyebleachCount && idx < items.length)
          post = items[idx++]
          url = post.data.url
          if (url.match('(.png|.gif|.jpg|.jpeg|.bmp)') or post.data.domain.match('(gfycat.com|imgur.com|livememe.com|memedad.com)')) and not url.match('.gifv')
            msg.send url
            num++

randomPost = (posts) ->
  random = Math.round(Math.random() * posts.data.children.length)
  posts.data.children[random]?.data

# stolen from http://stackoverflow.com/questions/6274339/how-can-i-shuffle-an-array-in-javascript
swap	= (input, x,  y) -> [input[x], input[y]] = [input[y], input[x]]
rand	= (x) -> Math.floor(Math.random() * x)
shuffle	= (input) -> swap(input, i, rand(i)) for i in [input.length - 1 .. 1]
