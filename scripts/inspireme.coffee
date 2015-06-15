# Description:
#   None
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   inspire-me - Displays a random sloth image
#
# Author:
#   April Ai (Sichun)

slothGifs = [
    'http://i.imgur.com/tNkzm5e.gif'
    'http://i.giphy.com/13yAFWBRPH1D1u.gif'
    'http://i.giphy.com/2XsvoCNOX7qh2.gif'
    'http://i.giphy.com/lc6ktWibqTxPq.gif'
    'http://i.giphy.com/I8eorWE0QuYYU.gif'
    'http://i.giphy.com/s4zt0MoO4BJyU.gif'
    'http://i.giphy.com/FjwNXz2pLmYow.gif'
    'http://i.giphy.com/XtfcGiT7z65t6.gif'
    'http://i.giphy.com/dMn8Sxl7Sluow.gif'
    'http://i.giphy.com/AposSatwmTvUc.gif'
    'http://i.giphy.com/YmkXyCBXEHwqI.gif'

]


module.exports = (robot) ->
  robot.hear /(inspire)(me)?/i, (msg) ->
    msg.send msg.random slothGifs
