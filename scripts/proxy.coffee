# Description:
#   randomly shows hubots true feelings regarding the proxy
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Author:
#   Kevin Behrens
#

threshold = 0.1

module.exports = (robot) ->
  robot.hear /(proxy)/i, (msg) ->

    random = Math.random()
    if random < threshold
      msg.send "When you say 'proxy' it makes me all:"
      msg.send "https://38.media.tumblr.com/3ab1d82ab79bff1f8d3c02ea4b40b66c/tumblr_n55btfZN741s0wwqso1_400.gif"
