# Description:
#   Listens for abandon thread in chat and responds with a random abandon thread GIF

# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   abandon thread - displays abandon thread gif
#
# Author:
#   JohnBork


abandon = [
  "http://i.imgur.com/68ipQjY.gif"
  "http://i.imgur.com/3mjtMB6.gif"
  "http://i.imgur.com/ZgwIASL.gif"
  "http://i.imgur.com/KR7aX9m.gif"
  "http://i2.kym-cdn.com/photos/images/masonry/000/988/092/1f2.gif"
  "https://media.giphy.com/media/DF6rYTdgCQ7qo/giphy.gif"
  "http://www.gifdivision.com/uploads/4/6/0/3/46032175/04_-_pnltk.gif"
  "http://i2.kym-cdn.com/photos/images/original/000/634/452/f00.gif"
]

module.exports = (robot) ->
  robot.respond /abandon[ ]*thread\b/i, (message) ->
    message.send message.random abandon
