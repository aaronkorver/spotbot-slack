# Description:
#   Display a shower thought.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot what are you thinking? - Grabs a random title from reddit.com/r/showerthoughts
#
# Author:
#   Matthew Dordal

## Curated list because reddit users don't tag content very well.
thoughts = [
  'A building is still called a building even after construction is finished.',
  'Han Solo doesn\'t seem so great when you realize who his real-world analog would be: A trucker doing cross-border smuggling for drug cartels, who shot a guy in a bar.',
  'The worlds oldest person also holds the world record for most laps around the sun.',
  'Hipster kids of the future will listen to nickleback to rebel against the "mainstream"',
  'Being a worm must be awesome. It\'s like "man, that dirt was great, I wish there was more." And there always is.',
  '"The early bird catches the worm" is actually advice to sleep in as late as possible...from the worm\'s perspective.',
  'In about 50 years horror movies will have ghosts that walk around staring at their smart phones.',
  'Spilling a beer is the adult equivalent of losing a balloon.',
  'What if I\'m bulletproof and I just don\'t know it yet.',
  'We wasted the name "Fly" on the worst animal.',
  'What if everytime you cracked your knuckles your fingers glowed like glow sticks.',
  'Adulthood is 50% "I\'m too young for this to be happening" and 50% "I\'m too old for this"."',
  'If I were stranded on an island with a fully functioning plane and runway... I\'d still be stranded on that island',
  'XML is like violence - if it doesn\’t solve your problems, you are not using enough of it.',
  'Cats are the type of animal that, if they could, they would correct your grammar.',
  'The @ symbol seems to make more sense for the word "around" than "at"',
  'I don\'t think the inventor of Twizzlers ever actually tasted a strawberry',
  'Pixar and Dreamworks sounds like the street names of hardcore drugs',
  'I wonder what people who write "u" instead of "you" do in all their free time',
  'There\'s no reason the alphabet has to be in order'
];

module.exports = (robot) ->
  robot.respond /what are you thinking\?/i, (msg) ->
    msg.reply(msg.random thoughts)
