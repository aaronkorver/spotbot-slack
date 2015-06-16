# Description:
#   The only perscription...is more cowbell
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   spotbot more cowbell
#
# Author:
#   SpencerGBull

cowbells = [
  "http://media.giphy.com/media/whOs1JywNpe6c/giphy.gif"
  "http://media.giphy.com/media/CMtBKBCUL2tvG/giphy.gif"
  "http://media.giphy.com/media/Yp1jHh7Lhg5gs/giphy.gif"
  "https://media3.giphy.com/media/gvbsAEvdp1N6w/200.gif"
  "http://media.giphy.com/media/yidUzpXGeYzwKRuxdS/giphy.gif"
  "http://media.giphy.com/media/2XskdWoiJLQfyGLFidG/giphy.gif"
  "http://media.giphy.com/media/3tag5Rqexv76o/giphy.gif"
  "http://media.giphy.com/media/w92Ni7aIRS3o4/giphy.gif"
  "https://31.media.tumblr.com/5ee9200a519c1d253150068ae36887a1/tumblr_mtp3iuitOw1sp41p1o1_400.gif"
  "https://31.media.tumblr.com/tumblr_m43clhQRYu1ro8ysbo1_400.gif"
  "https://33.media.tumblr.com/58bb4f76455116efc809e265e8859eb5/tumblr_mn5x05HSQe1qhlo8bo1_500.gif"
]

module.exports = (robot) ->
  robot.hear /more cowbell\b/i, (msg) ->
    msg.send msg.random cowbells
