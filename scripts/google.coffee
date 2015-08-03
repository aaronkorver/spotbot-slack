# Description:
#   Google any query
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot google me <query> - gives link for google search of query
#   hubot google lucky me <query> - gives link for Im Feeling Lucky of query
#
# Author:
#   jordanmcgowan

module.exports = (robot) ->
  robot.respond /google me (.*)/i, (msg) ->
      google msg, msg.match[1]
  robot.respond /google lucky me (.*)/i, (msg) ->
      googleFeelingLucky msg, msg.match[1]

googleFeelingLucky = (msg, query, cb) ->
    msg.http('http://ajax.googleapis.com/ajax/services/search/web?')
      .query(v: "1.0", rsz: '8',  q: query, safe: 'active')
      .get() (err, res, body) ->
        googleApiInfo = JSON.parse(body)
        googleApiInfo = googleApiInfo.responseData.results[0].unescapedUrl
        msg.send googleApiInfo


google = (msg, query) ->
    msg.http('http://ajax.googleapis.com/ajax/services/search/web?')
      .query(v: "1.0", rsz: '8',  q: query, safe: 'active')
      .get() (err, res, body) ->
        googleApiInfo = JSON.parse(body)
        googleApiInfo = googleApiInfo.responseData.cursor.moreResultsUrl
        msg.send googleApiInfo
