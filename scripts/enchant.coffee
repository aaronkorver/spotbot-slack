# Description:
#   Tim the Enchanter
#
# Commands:
#   hubot enchant me - responds with an animated gif of Tim conjuring waves


module.exports = (robot) ->
  robot.respond /(enchant)( me)?/i, (msg) ->
    msg.send 'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531191/urDhjswrtXU6InI/TimTheEnchanter_slow_resize.gif'