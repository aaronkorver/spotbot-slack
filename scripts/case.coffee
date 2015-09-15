# Description:
#   Display Case.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot case me - Gives you case
#
# Author:
#   akorver

module.exports = (robot) ->

  cases = [
    "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/7PYohL39KqHeglc/animated.gif"
    "https://s3.amazonaws.com/uploads.hipchat.com/171096/1531535/x1TM3MVqOMyE2qn/case-small.png"
    "(bicepleft)(case)(bicepright)"
    "https://s3.amazonaws.com/uploads.hipchat.com/171096%2F1531207%2Fp8e80fufYYCoftw%2Fgreg_waterfall_sm.gif"
    "https://s3.amazonaws.com/uploads.hipchat.com/171096%2F1531191%2FijQaSW0yxZeufbI%2Fa77ae2df_o.jpeg"
    "https://s3.amazonaws.com/uploads.hipchat.com/171096%2F1531191%2F0cUbET6jiIzuI28%2F9d33d889_o.gif"
    "https://s3.amazonaws.com/uploads.hipchat.com/171096/1531535/qXEVSGzgNqil6dl/GregEarl-small.png"
    "https://s3.amazonaws.com/uploads.hipchat.com/171096/1531535/WGyWMG3LXRsV4WF/greg-fireman-bed.png"
    "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/icv0loozkw1Miym/deal-with-case.gif"
    "https://s3.amazonaws.com/uploads.hipchat.com/171096/1531535/KAJhtNB0yCX3vD4/greg-horserace.png"
  ]

  robot.respond /(case)( me)/i, (msg) ->
    msg.send msg.random cases
