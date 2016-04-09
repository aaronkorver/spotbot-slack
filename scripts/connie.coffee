# Description:
#   Hubot displays a random daria gif when someone brings up the Connie.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   dakota.reesebrown (based on brilliantfantastic's ackbar script)

threshold = 0

connies = [
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/IEXCrI3xXl2tp9m/10Iu43S5QuBTMc.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/mMZefvBgGRNI3WJ/5wBBmDD10iAg.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/N3HROCjpgqKeUqi/H0lImuTYTVVWE.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/U6UDACNGSoHYbMC/gaOxhtFQiYYeI.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/Tk1RN3TKGx1XoAs/tumblr_mhs1a0vUzA1r42ynoo1_r3_500.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/BCELakqWVaUfFbI/tumblr_ltjcx16vO21qzovtro1_500.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/byyYnagJ8h58LFM/tumblr_lmim4kf25R1qb3cw3.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/TbqSEnAiuy4PLeb/tumblr_lshqisvAuw1r2wm2po1_r1_500.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/MZPgQzvBZ2yH6aV/image.png'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/kb4h56V5pcpvoeR/f691f5113467a86b8a9cbc8aab79d5c584b9bcfaf1210e7c78f73bed21b87672.jpg'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/hBdlo2BgfeZjF3W/c1fd4ecc0d24e3ff66f7a997e5848a7c.jpg'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/Eg7QlJl8k5VwbC4/11581930.jpg'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/2AlQFvmoGq7ArQj/tumblr_lmh6uwiHOC1qb3cw3.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/p4LgRu2AdtqUCxh/tumblr_lmh8v8Clka1qb3cw3.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/l6e6jLETbRqdIjL/GUfGNG3G6hKZG.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/FJCkYUhW3glwk82/giphy.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/nWn26zqe2yDaqDm/tumblr_lnk1oeENFJ1qcnbfpo1_400.gif'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/zEURqGiYXADPzkk/tumblr_m3cox5LWCa1qjn7buo1_500.jpg'
]

module.exports = (robot) ->
  robot.hear /\bconnie\b/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "connie", threshold)
    if random < roomThreshold
      msg.send msg.random connies
