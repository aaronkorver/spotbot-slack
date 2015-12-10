# Description:
#   Hubot picks random emojis.
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_HIPCHAT_TOKEN
#
# Commands:
#   hubot emoji me - Returns a random emoji
#   hubot emoji spin me - Spin the emoji slots
#   hubot emoji spin [top|bottom[ n]] spinners - List the users that make the most spins
#   hubot emoji spin [top|bottom[ n]] winners - Lists the users with the most wins
#
# Author:
#   sandbochs

Util = require "util"

class SpinStorage
  constructor: (@robot) ->
    @spins = {}
    @robot.brain.on 'loaded', =>
      @spins = @robot.brain.data.emojiSpins || {}

  playerDetails: (player) ->
    details = @spins[player]
    if (!details)
      details = {'plays': 0, 'wins': 0}
      @spins[player] = details
    details

  logSpin: (player, won) ->
    details = @playerDetails player
    details['plays']++
    if (won)
      details['wins']++
    @save()

  getRecords : (amount, asc, sortByWins) ->
      sorted = []
      for name, record of @spins
          sorted.push(name: name, wins: record.wins, plays: record.plays)
      amount = Math.min(amount, sorted.length)
      sorted.sort((a,b) ->
        if sortByWins
          if asc then b.wins - a.wins else a.wins - b.wins
        else
          if asc then b.plays - a.plays else a.plays - b.plays).slice(0, amount)

  save : ->
    @robot.brain.data.emojiSpins = @spins

emoji = "r2d2,rage,case,allthethings,android,areyoukiddingme,arrington,arya,ashton,atlassian,awesome,awthanks,aww,awwyiss,awyeah,badass,badjokeeel,badpokerface,badtime,basket,beer,bicepleft,bicepright,bitbucket,boom,borat,branch,bumble,bunny,cadbury,cake,candycorn,carl,caruso,catchemall,ceilingcat,celeryman,cereal,cerealspit,challengeaccepted,chef,chewie,chocobunny,chompy,chucknorris,clarence,coffee,confluence,content,continue,cookie,cornelius,corpsethumb,daenerys,dance,dealwithit,derp,disappear,disapproval,doge,doh,donotwant,dosequis,downvote,drevil,drool,ducreux,dumb,evilburns,excellent,facepalm,failed,feelsbadman,feelsgoodman,finn,fireworks,firstworldproblems,fonzie,foreveralone,freddie,fry,ftfy,fu,fuckyeah,fwp,gangnamstyle,gates,ghost,giggity,goldstar,goodnews,greenbeer,grumpycat,gtfo,haha,haveaseat,heart,heygirl,hipchat,hipster,hodor,huehue,hugefan,huh,ilied,indeed,iseewhatyoudidthere,itsatrap,jackie,jaime,jake,jira,jobs,joffrey,jonsnow,kennypowers,krang,kwanzaa,lincoln,lol,lolwut,megusta,meh,menorah,mindblown,motherofgod,ned,nextgendev,nice,ninja,noidea,notbad,nothingtodohere,notit,notsureif,notsureifgusta,obama,ohcrap,ohgodwhy,ohmy,okay,omg,orly,paddlin,pbr,philosoraptor,pingpong,pirate,pokerface,poo,present,pumpkin,rageguy,rainicorn,rebeccablack,reddit,rockon,romney,rudolph,sadpanda,sadtroll,salute,samuel,santa,sap,scumbag,seomoz,shamrock,shrug,skyrim,standup,stare,stash,success,successful,sweetjesus,tableflip,taco,taft,tea,thatthing,theyregreat,toodamnhigh,tree,troll,truestory,trump,turkey,twss,tyrion,tywin,unacceptable,unknown,upvote,vote,waiting,washington,wat,whoa,whynotboth,wtf,yeah,yey,yodawg,youdontsay,yougotitdude,yuno,zoidberg".split(',')
lose_responses = ['You lose!']
win_responses = ['You win!']
spinStorage = undefined

module.exports = (robot) ->

  spinStorage = new SpinStorage robot

  robot.respond /emoji( me)?$/i, (message) ->
    message.send random_emoji()
  robot.respond /emoji spin( me)?$/i, (message) ->
    message.send spin_emoji(message.message.user.name)
  robot.respond /emoji spin( (top|bottom)( [0-9]+)?)? win(ner)?s/i, (message) ->
    message.send spin_report(message.match[2], message.match[3], true)
  robot.respond /emoji spin( (top|bottom)( [0-9]+)?)? (play(er)?|spin(ner)?)s/i, (message) ->
    message.send spin_report(message.match[2], message.match[3], false)

  if process.env.HUBOT_HIPCHAT_TOKEN?
    robot.http("https://api.hipchat.com/v2/emoticon")
      .header('Accept', 'application/json')
      .query({
        auth_token: process.env.HUBOT_HIPCHAT_TOKEN
        'max-results': 1000
      })
      .get() (err, res, body) ->
        emoji_obj = JSON.parse(body)

        unless emoji_obj.items?
          return

        emoji = []
        emoji_obj.items.forEach (item) ->
          emoji.push item.shortcut

        return emoji

random_emoji = (num = 1) ->
  return "(#{emoji[random_index(emoji)]})" if num == 1

  emojis = []

  while emojis.length < num
    r_emoji = emoji[random_index(emoji)]
    emojis.push("(#{r_emoji})") unless includes(emojis, "(#{r_emoji})")

  emojis

spin_emoji = (player) ->
  pool = random_emoji 4
  spin = []
  counts = [0, 0, 0, 0]
  win = false
  chucknorriswin = false
  while spin.length < 3
    index = random_index(pool)
    spin.push pool[index]
    counts[index] += 1
    # because chucknorris never loses
    if pool[index] == '(chucknorris)'
      chucknorriswin = true

  for count in counts
    win = true if count == 3

  if win == true
    if chucknorriswin == true
      response = "Chuck Norris always WINS!"
    else 
      response = win_responses[random_index(win_responses)]
    spinStorage.logSpin(player, true)
  else
    if chucknorriswin == true
      response = "Chuck Norris never loses!"
      spinStorage.logSpin(player, true)
    else
      response = lose_responses[random_index(lose_responses)]
      spinStorage.logSpin(player, false)

  "#{spin.join(' | ')} : #{response}"

spin_report = (ordering, count, sortByWins) ->
  asc = true
  sliceSize = 5
  report = []
  if (ordering && ordering.toLowerCase() == 'bottom' )
    asc = false
  if (count)
    sliceSize = count
  records = spinStorage.getRecords(sliceSize,asc,sortByWins)
  for record in records
    winPercent = (record.wins/record.plays*100).toFixed(4)
    if sortByWins
      report.push "#{record.name} has won #{record.wins} times (#{winPercent}% win ratio)"
    else
      report.push "#{record.name} has spun #{record.plays} times (#{winPercent}% win ratio)"
  report.join("\n")

random_index = (array) ->
  Math.floor(Math.random() * array.length)

includes = (array, element) ->
  for el in array
    return true if el == element

  false
