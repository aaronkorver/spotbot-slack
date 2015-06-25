# Description:
#   A way to interact with the Google Images API.
#
# Commands:
#   hubot muppet me - responds with an animated gif of Bruce saying something about Muppets
#   hubot bruce me - responds with bruce type message
#   hubot ask bruce about [name] - Spotbot will ask Bruce about a person



brucisms = [
    "He had a face like a smacked as$"
    "Muppets. ALL of them! MUPPETS"
    "It's like a hornet's nest... of sh$%."
    "They're castrating me."
    "It's like a monkey f$%&ing a football"
    "[He is] as mean as a bulldog shitting tacks."
    "[It's] worth as much as a fart in a pair of pajamas."
    "I'm wired to the point where my arse is puckered."
    "Nice to bloody meet you."
    "In Minnesota it's so cold you have to knock the dog off the light pole!"
    "They're all bloody muppets!"
    "No. You don't want to do that, not while you have a hole in your bum."
    "... it'd be fast, like greased weasel $hit."
    "Every night I get home and have palpitations." 
    "The whole thing went tits up."
    "Cheers"
    "He is a yard dog."
    "They don't know f%*k all about that."
    "It's a bit of water."
    "He's all mouth and no trousers."
    "They make me feel about as welcome as a fart in a spacesuit."
    "He is a f*%cking peasant."
    "I'm as stubborn as a f*%ing mule."
    "I'm as tight as a camel's arse in a sandstorm."
    "I almost went arse over whatsit this morning."
    "Shirt's a bit tight. My nipples are sore. Gonna have to put pasties on over lunch."
    "I almost went arse over whatsit this morning."
    "I don't want this to just be a grin and fuck."
    "I'm having a hot flash... I think I'm going through menopause."
    "It goes up and down like a whore's drawers."
    "Oh God.  Some Vicodin and some Patron is what I need."
    "I don't care if we have to pee out a window as long as we get it to work."
    "I’m chuffed to bits to see the hounding is starting to work."
]

abouts = [
    "NAME has a face like a smacked as$"
    "NAME is a bloody MUPPET!"
    "NAME as mean as a bulldog shitting tacks."
    "NAME is worth as much as a fart in a pair of pajamas."
    "NAME is a yard dog."
    "NAME doesn't know f%*k all about that."
    "NAME is all mouth and no trousers."
    "NAME makes me feel about as welcome as a fart in a spacesuit."
    "NAME is a f*%cking peasant."
]


module.exports = (robot) ->
  robot.respond /(muppet)( me)?/i, (msg) ->
    msg.send 'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531191/5QypdcNRxtsthTR/fmuppets.gif'

  robot.respond /(bruce)( me)?/i, (msg) ->
    response = msg.random brucisms
    msg.send ('Bruce says: "' + response + '"')

  robot.respond /(ask bruce about )( me )?(.*)/i, (msg) ->
    whom = msg.match[3]
    insult = msg.random abouts
    insult = insult.replace(/NAME/, whom)
    msg.send ('Bruce says: "' + insult + '"')
