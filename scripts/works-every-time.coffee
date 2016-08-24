# Description:
#   Works every time
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   works every time - colt 45
#
# Author:
#   atmos

module.exports = (robot) ->
  robot.hear /works every time/i, (message) ->
    message.send "https://cdn.shopify.com/s/files/1/1019/0339/products/bdw_6.jpeg?v=1444403015"
