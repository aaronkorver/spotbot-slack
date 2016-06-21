# Description:
#   Random SpongeBob gif generator
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   sponge me - Displays a random spongebob gif
#
# Author:
#   Lymari Montijo

spongeGifs = [
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/4014412/97y7JZ1aP4qNO4Z/3E0czvVwdjo2I.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/4014412/TekvJlvh0k5PyNQ/beLG3rdCb9fdS.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/4014412/ggL0452zZ0kg06W/HxOxEt3qQ25YQ.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/4014412/YukX3oQTPQSjOjQ/LdOyjZ7io5Msw.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/4014412/Ub6qSPWOZ0OLAgl/43sMhXiELKzNm.gif' 
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/4014412/zzT0H2MDEoxkmfn/TgIvQCIOoc78k.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/4014412/apX99wsdAsMQAb7/X4M6homF66qFq.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/4014412/1lSpjQH6tRSN0TT/QV8RROsO4wjzW.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/4014412/tgiXBbFIJNpLO4H/HcwAhlzuJQHDO.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/4014412/57l8qm2Yg9Sp6OQ/vaq9VvnAHlsEo.gif'

]

module.exports = (robot) ->
  robot.respond /spongebob ?me/i, (msg) ->
    msg.send msg.random spongeGifs
