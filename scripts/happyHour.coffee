# Description:
#   Returns happy hour for the given bar/restaurant, unless canned response
#
# Dependencies:
#   cheerio
#
# Configuration:
#   None
#
# Commands:
#   spotbot happy hour <bar name> - Searches for available happy hours at http://minneapolis.cities2night.com/happyhours
#
# Author:
#   mickWhite

cheerio = require 'cheerio'

cannedResp = {
  flintmi: '1/2 off Water! (may contain lead)'
  stpaul: 'there are only Sad Hours in St.Paul'
  minneapolis: 'sure, what bar in Minneapolis?'
  source: 'this tells me all that I know... http://minneapolis.cities2night.com/happyhours'
}

module.exports = (robot) ->

  robot.respond /happy hour$\b/i, (msg) ->
    msg.send 'where?'

  robot.respond /happy hour (.*)/i, (msg) ->
    queryBar = msg.match[1].replace("'", "").replace(',', '').toLowerCase()
    if cannedResp.hasOwnProperty(queryBar.replace(' ', '').replace('.', ''))
      msg.send cannedResp[queryBar.replace(' ', '').replace('.', '')]
    else
      msg.http("http://minneapolis.cities2night.com/happyhours")
      .get() (err, resp, body) ->
        $ = cheerio.load(body)
        specials = []
        $('li[class="featured"]').each ->
          foundBar = $(this).children('span[class="featured-barwrap"]').children('span[class="place-details"]').text().replace("'", "").toLowerCase()
          if foundBar.match queryBar
            special =
              barName : $(this).children('span[class="featured-barwrap"]').children('span[class="place-details"]').text().split(' (')[0]
              specialTime: $(this).children('span[class="special-time"]').children('span[class="time-range"]').text().strip('\n')
              specialDesc: $(this).children('span[class="left-wrap"]').children('span[class="special-description"]').text()
            specials.push(special)
        $('li[class="regular"]').each ->
          foundBar = $(this).children('span[class="right-wrap"]').children('span[class="featured-barwrap"]').children('span[class="place-details"]').text().replace("'", "").toLowerCase()
          if foundBar.match queryBar
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
