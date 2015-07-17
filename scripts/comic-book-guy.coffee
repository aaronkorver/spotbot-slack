# Description:
#   Comic Book Guy quotes
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot comic book guy => random comic book guy quote

# Author:
#   MatthewDordal

comicBookGuyQuotes = [
  'Oh, loneliness and cheeseburgers are a dangerous mix.',
  'Are you the creator of Hi And Lois? Because you are making me laugh.',
  'Since we are not familiar with sarcasm, I shall close the cash register.',
  'Oh, a sarcasm detector. Oh, that’s a real useful invention!',
  'There’s no emoticon for what I’m feeling',
  'Last night’s Itchy & Scratchy was without a doubt the Worst. Episode. Ever. Rest assured I was on the internet in minutes registering my disgust throughout the world.',
  'I must return to my comic book store, where I dispense the insults rather than absorb them.',
  'But Aquaman, you cannot marry a woman without gills, you’re from two different worlds! ...Oh, I’ve wasted my life.',
  'You may purchase this charming Hamburglar adventure. A child has already solved the jumble using crayons. The answer is "fries"',
  'Ooh, your powers of deduction are exceptional. I simply can\'t allow you to waste them here when there are so many crimes going unsolved at this very moment. Go! Go! For the good of the city!',
  'Someone has mixed an "Amazing Spider-Man" in with the "Peter Parker - The Spectacular Spider-Man" series. This will not stand.'
]

module.exports = (robot) ->
  robot.respond /comic book guy/i, (msg) ->
    msg.reply( "#{ msg.random comicBookGuyQuotes }" )