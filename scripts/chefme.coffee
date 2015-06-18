# Description:
#   Chef me
#
# Commands:
#   hubot chef me - respond with random Swedish/South Park Chef gif

chefs= [
  'http://i.imgur.com/Ok7etRo.gif'
  'http://i.imgur.com/FJrqMVN.gif'
  'http://i.imgur.com/kQqBKhW.gif'
  'http://i.imgur.com/JSMMQuf.gif'
  'http://i.imgur.com/QOekaTh.gif'
  'http://i.imgur.com/n9J3wd6.gif'
  'http://i.imgur.com/uP6rhqe.jpg'
  'http://i.imgur.com/lGvFAsc.gif'
  'http://i.imgur.com/ZR1Vff7.gif'
  'http://i.imgur.com/doOg4gt.gif'
  'http://i.imgur.com/PZZ0BtG.gif'
  'http://i.imgur.com/d7UGtl7.gif'
]


module.exports = (robot) ->
  robot.respond /(chef)( me)?/i, (msg) ->
    msg.send msg.random chefs
