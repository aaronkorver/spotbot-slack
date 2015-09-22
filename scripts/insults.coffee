# Description:
#   insult engine 1.1
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot you stink - Insults the sender
#   hubot insult <target> - Insults the target
#
# Author:
#   alisonbeattie
#

swashbuckle = [
  "NAME fights like a Dairy Farmer!"
  "This is the END for you, NAME, you gutter crawling cur!"
  "I've spoken with apes more polite than NAME!"
  "Soon NAME will be wearing my sword like a shish kebab!"
  "I once owned a dog that was smarter than NAME."
  "Have you stopped wearing diapers yet, NAME?"
  "Your hemorroids are flaring up again eh, NAME?"
  "First you better stop waving it about like a feather duster, NAME."
  "NAME is no match for my brains, the poor fool."
  "I hope now you've learned to stop picking your nose, NAME."
  "There are no words for how disgusting NAME is."
  "NAME has the manners of a beggar."
  "After meeting NAME, I know what filth and stupidity really are."
  "NAME is as repulsive as a monkey in a negligee."
  "When your father first saw you, he must have been mortified, NAME!"
]

swashbuckleMe = [
  "You fight like a Dairy Farmer!"
  "This is the END for you, you gutter crawling cur!"
  "I've spoken with apes more polite than you!"
  "Soon you'll be wearing my sword like a shish kebab!"
  "I once owned a dog that was smarter than you."
  "Have you stopped wearing diapers yet?"
  "Your hemorroids are flaring up again eh?"
  "You're no match for my brains, you poor fool."
  "I hope now you've learned to stop picking your nose."
  "There are no words for how disgusting you are."
  "You have the manners of a beggar."
  "Now I know what filth and stupidity really are."
  "You're as repulsive as a monkey in a negligee."
  "When your father first saw you, he must have been mortified!"
  "You can't match my witty repartee!"
]

module.exports = (robot) ->

  # This matches a variety of lily-livered insults
  robot.respond /(you (stink|suck)|you('re| are) (a moron|an idiot|stupid))| shut (up|it)/i, (msg) ->
    msg.reply msg.random swashbuckleMe

  robot.respond /insult (.*)/i, (msg) ->
    whom = msg.match[1]
    response = msg.random swashbuckle
    response = response.replace(/NAME/, whom)
    msg.send (response)
