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
#   culvinize - Displays a random culvinization
#
# Author:
#   dakota.reesebrown

culviners = [
  {url: "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/L5zBxiz3tKE4PyV/rogue.png",      weight: 10},
  {url: "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/8Yl2yFy041FwdvO/culvinized-1.png", weight: 1},
  {url: "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/57BrwqVEIcKKzjO/culvinized-2.png", weight: 1},
  {url: "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/uQ6BoxbT0FoAA6G/culvinized-3.png", weight: 1},
  {url: "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/1xFiNMeFePDUwDN/culvinized-4.png", weight: 1},
  {url: "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/3PtwiZBXmiCIDUV/culvinized-5.jpg", weight: 1},
  {url: "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/zvccc8ihS772Q2Q/culvinized-6.jpg", weight: 1},
  {url: "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/8R0U2wlwWXdZK1D/culvinized-7.png", weight: 1},
  {url: "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/Bfy6rn4llKl92KT/culvinized-8.jpg", weight: 1},
  {url: "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/JQms0xr2kUT9x9F/culvinized-9.jpg", weight: 1},
  {url: "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/Y6ADEqRHRmXdqXy/culvinized-10.png", weight: 1}
  {url: "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/QpDCFGtMY1ZJ6dE/culvinized-rake.png, weight : 1}
]

max = 0
for item in culviners
  max += item.weight


module.exports = (robot) ->
  robot.hear /culvinize/i, (msg) ->
    random = Math.random() * max
    weighting = 0
    for item in culviners
      if (random < weighting + item.weight)
        culvin = item.url
        break
      else
        weighting += item.weight

    msg.send culvin
