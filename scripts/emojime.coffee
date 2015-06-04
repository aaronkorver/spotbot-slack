# Description:
#   Hubot picks random emojis.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot emoji me - Returns a random emoji
#   hubot emoji spin me - Spin the emoji slots
#   hubot emoji card me - Returns a random card against humanity with emoji
#
# Author:
#   sandbochs

emoji = "r2d2,rage,case,allthethings,android,areyoukiddingme,arrington,arya,ashton,atlassian,awesome,awthanks,aww,awwyiss,awyeah,badass,badjokeeel,badpokerface,badtime,basket,beer,bicepleft,bicepright,bitbucket,boom,borat,branch,bumble,bunny,cadbury,cake,candycorn,carl,caruso,catchemall,ceilingcat,celeryman,cereal,cerealspit,challengeaccepted,chef,chewie,chocobunny,chompy,chucknorris,clarence,coffee,confluence,content,continue,cookie,cornelius,corpsethumb,daenerys,dance,dealwithit,derp,disappear,disapproval,doge,doh,donotwant,dosequis,downvote,drevil,drool,ducreux,dumb,evilburns,excellent,facepalm,failed,feelsbadman,feelsgoodman,finn,fireworks,firstworldproblems,fonzie,foreveralone,freddie,fry,ftfy,fu,fuckyeah,fwp,gangnamstyle,gates,ghost,giggity,goldstar,goodnews,greenbeer,grumpycat,gtfo,haha,haveaseat,heart,heygirl,hipchat,hipster,hodor,huehue,hugefan,huh,ilied,indeed,iseewhatyoudidthere,itsatrap,jackie,jaime,jake,jira,jobs,joffrey,jonsnow,kennypowers,krang,kwanzaa,lincoln,lol,lolwut,megusta,meh,menorah,mindblown,motherofgod,ned,nextgendev,nice,ninja,noidea,notbad,nothingtodohere,notit,notsureif,notsureifgusta,obama,ohcrap,ohgodwhy,ohmy,okay,omg,orly,paddlin,pbr,philosoraptor,pingpong,pirate,pokerface,poo,present,pumpkin,rageguy,rainicorn,rebeccablack,reddit,rockon,romney,rudolph,sadpanda,sadtroll,salute,samuel,santa,sap,scumbag,seomoz,shamrock,shrug,skyrim,standup,stare,stash,success,successful,sweetjesus,tableflip,taco,taft,tea,thatthing,theyregreat,toodamnhigh,tree,troll,truestory,trump,turkey,twss,tyrion,tywin,unacceptable,unknown,upvote,vote,waiting,washington,wat,whoa,whynotboth,wtf,yeah,yey,yodawg,youdontsay,yougotitdude,yuno,zoidberg".split(',')
lose_responses = ['You lose!']
win_responses = ['You win!']
black_cards = "TSA guidelines now prohibit __________ on airplanes.<>It's a pity that kids these days are all getting involved with __________.<>In 1,000 years, when paper money is but a distant memory, __________ will be our currency.<>Major League Baseball has banned __________ for giving players an unfair advantage.<>What is Batman's guilty pleasure?<>Next from J.K. Rowling: Harry Potter and the Chamber of __________.<>I'm sorry, Professor, but I couldn't complete my homework because of __________.<>What did I bring back from Mexico?<>__________? There's an app for that.<>Betcha can't have just one!<>What's my anti-drug?<>While the United States raced the Soviet Union to the moon, the Mexican government funneled millions of pesos into research on __________.<>In the new Disney Channel Original Movie, Hannah Montana struggles with __________ for the first time.<>What's my secret power?<>What's the new fad diet?<>What did Vin Diesel eat for dinner?<>When Pharaoh remained unmoved, Moses called down a Plague of __________.<>How am I maintaining my relationship status?<>What's the crustiest?<>When I'm in prison, I'll have __________ smuggled in.<>After Hurricane Katrina, Sean Penn brought __________ to the people of New Orleans.<>Instead of coal, Santa now gives the bad children __________.<>Life was difficult for cavemen before __________.<>What's Teach for America using to inspire inner city students to succeed?<>Who stole the cookies from the cookie jar?<>In Michael Jackson's final moments, he thought about __________.<>White people like __________.<>Why do I hurt all over?<>A romantic candlelit dinner would be incomplete without __________.<>What will I bring back in time to convince people that I am a powerful wizard?<>BILLY MAYS HERE FOR __________.<>The class field trip was completely ruined by __________.<>What's a girl's best friend?<>I wish I hadn't lost the instruction manual for __________.<>When I am President of the United States, I will create the Department of __________.<>What are my parents hiding from me?<>What never fails to liven up the party?<>What gets better with age?<>__________: good to the last drop.<>I got 99 problems but __________ ain't one.<>It's a trap!<>MTV's new reality show features eight washed-up celebrities living with __________.<>What would grandma find disturbing, yet oddly charming?<>What's the most emo?<>During sex, I like to think about __________.<>What ended my last relationship?<>What's that sound?<>__________. That's how I want to die.<>Why am I sticky?<>What's the next Happy MealÃ‚Â® toy?<>What's there a ton of in heaven?<>I do not know with what weapons World War III will be fought, but World War IV will be fought with __________.<>What will always get you laid?<>__________: kid tested, mother approved.<>Why can't I sleep at night?<>What's that smell?<>What helps Obama unwind?<>This is the way the world ends \ This is the way the world ends \ Not with a bang but with __________.<>Coming to Broadway this season, __________: The Musical.<>Anthropologists have recently discovered a primitive tribe that worships __________.<>But before I kill you, Mr. Bond, I must show you __________.<>Studies show that lab rats navigate mazes 50% faster after being exposed to __________.<>Due to a PR fiasco, Walmart no longer offers __________.<>When I am a billionaire, I shall erect a 50-foot statue to commemorate __________.<>In an attempt to reach a wider audience, the Smithsonian Museum of Natural History has opened an interactive exhibit on __________.<>War! What is it good for?<>What gives me uncontrollable gas?<>What do old people smell like?<>Sorry everyone, I just __________.<>Alternative medicine is now embracing the curative powers of __________.<>The U.S. has begun airdropping __________ to the children of Afghanistan.<>What does Dick Cheney prefer?<>During Picasso's often-overlooked Brown Period, he produced hundreds of paintings of __________.<>What don't you want to find in your Chinese food?<>I drink to forget __________.<>TSA guidelines now prohibit __________ on airplanes.<>It's a pity that kids these days are all getting involved with __________.<>In 1,000 years, when paper money is but a distant memory, __________ will be our currency.<>Major League Baseball has banned __________ for giving players an unfair advantage.<>What is Batman's guilty pleasure?<>Next from J.K. Rowling: Harry Potter and the Chamber of __________.<>I'm sorry, Professor, but I couldn't complete my homework because of __________.<>What did I bring back from Mexico?<>__________? There's an app for that.<>__________. Betcha can't have just one!<>What's my anti-drug?<>While the United States raced the Soviet Union to the moon, the Mexican government funneled millions of pesos into research on __________.<>In the new Disney Channel Original Movie, Hannah Montana struggles with __________ for the first time. <>What's my secret power?<>What's the new fad diet?<>What did Vin Diesel eat for dinner?<>When Pharaoh remained unmoved, Moses called down a Plague of __________.<>How am I maintaining my relationship status?<>What's the crustiest?<>In L.A. County Jail, word is you can trade 200 cigarettes for __________.<>After the earthquake, Sean Penn brought __________ to the people of Haiti.<>Instead of coal, Santa now gives the bad children __________.<>Life for American Indians was forever changed when the White Man introduced them to __________.<>What's Teach for America using to inspire inner city students to succeed?<>Maybe she's born with it. Maybe it's __________.<>In Michael Jackson's final moments, he thought about __________.<>White people like __________.<>Why do I hurt all over?<>A romantic, candlelit dinner would be incomplete without __________.<>What will I bring back in time to convince people that I am a powerful wizard?<>BILLY MAYS HERE FOR __________.<>The class field trip was completely ruined by __________.<>What's a girl's best friend?<>Dear Abby, I'm having some trouble with __________ and would like your advice.<>When I am President of the United States, I will create the Department of __________.<>What are my parents hiding from me?<>What never fails to liven up the party?<>What gets better with age?<>__________: Good to the last drop.<>I got 99 problems but __________ ain't one.<>__________. It's a trap!<>MTV's new reality show features eight washed-up celebrities living with __________.<>What would grandma find disturbing, yet oddly charming?<>What's the most emo?<>During sex, I like to think about __________.<>What ended my last relationship?<>What's that sound?<>__________. That's how I want to die.<>Why am I sticky?<>What's the next Happy Meal toy?<>What's there a ton of in heaven?<>I do not know with what weapons World War III will be fought, but World War IV will be fought with __________.<>What will always get you laid?<>__________: Kid-tested, mother-approved.<>Why can't I sleep at night?<>What's that smell?<>What helps Obama unwind?<>This is the way the world ends / This is the way the world ends / Not with a bang but with __________.<>Coming to Broadway this season, __________: The Musical.<>Anthropologists have recently discovered a primitive tribe that worships __________.<>But before I kill you, Mr. Bond, I must show you __________.<>Studies show that lab rats navigate mazes 50% faster after being exposed to __________.<>Next on ESPN2: The World Series of __________.<>When I am a billionaire, I shall erect a 50-foot statue to commemorate __________.<>In an attempt to reach a wider audience, the Smithsonian Museum of Natural History has opened an interactive exhibit on __________.<>War! What is it good for?<>What gives me uncontrollable gas?<>What do old people smell like?<>What am I giving up for Lent?<>Alternative medicine is now embracing the curative powers of __________.<>What did the US airdrop to the children of Afghanistan?<>What does Dick Cheney prefer?<>During Picasso's often-overlooked Brown Period, he produced hundreds of paintings of __________.<>What don't you want to find in your Chinese food?<>I drink to forget __________.<>__________. High five, bro.<>He who controls __________ controls the world.<>The CIA now interrogates enemy agents by repeatedly subjecting them to __________.<>In Rome, there are whisperings that the Vatican has a secret room devoted to __________.<>Science will never explain the origin of __________.<>When all else fails, I can always masturbate to __________.<>I learned the hard way that you can't cheer up a grieving friend with __________.<>In its new tourism campaign, Detroit proudly proclaims that it has finally eliminated __________.<>The socialist governments of Scandinavia have declared that access to __________ is a basic human right.<>In his new self-produced album, Kanye West raps over the sounds of __________.<>What's the gift that keeps on giving?<>This season on Man vs. Wild, Bear Grylls must survive in the depths of the Amazon with only __________ and his wits. <>When I pooped, what came out of my butt?<>In the distant future, historians will agree that __________ marked the beginning of America's decline.<>What has been making life difficult at the nudist colony?<>And I would have gotten away with it, too, if it hadn't been for __________.<>What brought the orgy to a grinding halt?<>That's right, I killed __________. How, you ask? __________.<>And the Academy Award for __________ goes to __________.<>For my next trick, I will pull __________ out of __________.<>In his new summer comedy, Rob Schneider is __________ trapped in the body of __________.<>When I was tripping on acid, __________ turned into __________.<>__________ is a slippery slope that leads to __________.<>In a world ravaged by __________, our only solace is __________.<>In M. Night Shyamalan's new movie, Bruce Willis discovers that __________ had really been __________ all along.<>I never truly understood __________ until I encountered __________.<>Rumor has it that Vladimir Putin's favorite dish is __________ stuffed with __________.<>LifetimeÃ‚Â® presents __________, the story of __________.<>What's the next superhero/sidekick duo?".split('<>')

module.exports = (robot) ->
  robot.respond /emoji( me)?$/i, (message) ->
    message.send random_emoji()
  robot.respond /emoji spin( me)?/i, (message) ->
    message.send spin_emoji()
  robot.respond /emoji card( me)?/i, (message) ->
    message.send card_emoji()

random_emoji = (num = 1) ->
  return "(#{emoji[random_index(emoji)]})" if num == 1

  emojis = []

  while emojis.length < num
    r_emoji = emoji[random_index(emoji)]
    emojis.push("(#{r_emoji})") unless includes(emojis, r_emoji)

  emojis

spin_emoji = ->
  pool = random_emoji 4
  spin = []
  counts = [0, 0, 0, 0]
  win = false

  while spin.length < 3
    index = random_index(pool)
    spin.push pool[index]
    counts[index] += 1

  for count in counts
    win = true if count == 3

  if win == true
    response = win_responses[random_index(win_responses)]
  else
    response = lose_responses[random_index(lose_responses)]

  "#{spin.join(' | ')} : #{response}"

card_emoji = ->
  replaced = false
  card = black_cards[random_index(black_cards)].split(' ')

  for word in card
    if word.match(/_{10}/)
      card[_i] = random_emoji()
      replaced = true

  card.push " #{random_emoji()}" if replaced == false
  card.join " "


random_index = (array) ->
  Math.floor(Math.random() * array.length)

includes = (array, element) ->
  for el in array
    return true if el == element

  false
