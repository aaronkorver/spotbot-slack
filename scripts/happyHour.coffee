# Description:
#   Returns happy hour for the given bar/restaurant, a random bar if none given, or a canned response
#
# Dependencies:
#   cheerio
#
# Configuration:
#   None
#
# Commands:
#   hubot happy hour [bar name] - Searches for happy hour in Minneapolis or at bar given.
# Author:
#   mickWhite

cheerio = require 'cheerio'

cannedResp = {
  flint: '1/2 off Water! (may contain lead)'
  stpaul: 'There are only Sad Hours in St.Paul'
  minneapolis: 'Sure, what bar in Minneapolis?'
}

module.exports = (robot) ->

  robot.respond /happy hour$\b/i, (msg) ->
    happyHour('random', msg)

  robot.respond /happy hour (.*)/i, (msg) ->
    queryBar = msg.match[1].replace("'", "").replace(',', '').toLowerCase()
    if cannedResp.hasOwnProperty(queryBar.replace(' ', '').replace('.', ''))
      msg.send cannedResp[queryBar.replace(' ', '').replace('.', '')]
    else
      happyHour(queryBar, msg)

  happyHour = (queryBar, msg) ->
    msg.http("http://minneapolis.cities2night.com/happyhours")
    .get() (err, resp, body) ->
      $ = cheerio.load(body)
      specials = []
      if queryBar is 'random'
        barIndex = Math.floor(Math.random() * $('li[class="regular"]').length)
      $('li[class="featured"]').each ->
        foundBar = $(this).children('span[class="featured-barwrap"]').children('span[class="place-details"]').text().replace("'", "").toLowerCase()
        if foundBar.match queryBar
          special =
            barName : $(this).children('span[class="featured-barwrap"]').children('span[class="place-details"]').text().split(' (')[0]
            specialTime: $(this).children('span[class="special-time"]').children('span[class="time-range"]').text().strip('\n')
            specialDesc: $(this).children('span[class="left-wrap"]').children('span[class="special-description"]').text()
          specials.push(special)
      $('li[class="regular"]').each (index) ->
        foundBar = $(this).children('span[class="right-wrap"]').children('span[class="featured-barwrap"]').children('span[class="place-details"]').text().replace("'", "").toLowerCase()
        if (foundBar.match queryBar) or (index is barIndex)
          special =
            barName : $(this).children('span[class="right-wrap"]').children('span[class="featured-barwrap"]').children('span[class="place-details"]').text()
            specialTime: $(this).children('span[class="left-wrap"]').children('span[class="special-time"]').text()
            specialDesc: $(this).children('span[class="right-wrap"]').children('span[class="special-description"]').text()
          specials.push(special)
      if specials.length > 0
        if specials.length > 3
          msg.send 'Whoa, more than 3 happy hours found for ' + msg.match[1] + '! Just go, or be more specific...'
        else
          for special, index in specials
            msg.send 'Happy hour ' + specials[index].barName + ' is ' + specials[index].specialDesc + ' at ' + specials[index].specialTime
      else
        msg.send 'No happy hours found for ' + msg.match[1]
