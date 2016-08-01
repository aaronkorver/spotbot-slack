# Description:
#   BRO COP
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   bro cop - displays a random bro cop gif
#
# Author:
#   Kurt Poquette

threshold = 1
cops= [
 "https://s3.amazonaws.com/uploads.hipchat.com/171096/4087024/yP6OMw7rCXRGHZD/cops-12.gif"
 "https://s3.amazonaws.com/uploads.hipchat.com/171096/4087024/CtbhZGRcMpjXPUQ/cops-11.gif"
 "https://s3.amazonaws.com/uploads.hipchat.com/171096/4087024/e0YRxqGbUpVEjsm/cops-10.gif"
 "https://s3.amazonaws.com/uploads.hipchat.com/171096/4087024/aPzCBN1Y2g2S3OS/cops-9.gif"
 "https://s3.amazonaws.com/uploads.hipchat.com/171096/4087024/DbSWbfYdTv9Rg1D/cops-7.gif"
 "https://s3.amazonaws.com/uploads.hipchat.com/171096/4087024/l5MJGAWOh1AnzAi/cops-6.gif"
 "https://s3.amazonaws.com/uploads.hipchat.com/171096/4087024/qXnnw6pIO54PY5q/cops-5.gif"
 "https://s3.amazonaws.com/uploads.hipchat.com/171096/4087024/797llnO3bkw9TvK/cops-4.gif"
 "https://s3.amazonaws.com/uploads.hipchat.com/171096/4087024/hK0SUsBzT1EgBVD/cops-3.gif"
 "https://s3.amazonaws.com/uploads.hipchat.com/171096/4087024/rCMWMwuS4ipBHEv/cops-2.gif"
 "https://s3.amazonaws.com/uploads.hipchat.com/171096/4087024/ksqeSaVa87aMx72/cops-1.gif"
]


module.exports = (robot) ->
  robot.hear /bro ?cop/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "cop", threshold)
    if random < roomThreshold
      msg.send msg.random cops
