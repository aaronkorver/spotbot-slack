# Description:
#   Subscribe to Target Facts!
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot target fact - returns a random true/false taget fact
#
# Author:
#   Marina Kent, Jessica Nelson, Mackenzie Flickinger

truthiness_values = [true,false]

true_facts = [
    "The first Target store was opened in Roseville, MN."
    "The first Target was created in 1962."
    "Team members began wearing red shirts and khaki in 1993."
    "Target has 1,792 stores in the United States."
    "Target has 38 distribution centers in the United States."
    "Target has 341,000 team members worldwide."
    "The median age of Target's guest is 40."
    "The median household income of Target's guests is $64,000"
    "Target's purpose and beliefs slogan is 'We fulfill the needs and fuel the potential of our guests.'"
    "Brian Cornell is the Board Chairman and CEO of Target."
    "Michael McNamara is the CIO of Target."
    "The first Target opened in 1962 in Roseville, MN."
    "Target team members wear Red and Khaki."
    "Bullseye became the official ambassador of Target in 1999."
    "George Draper Dayton is the founder of what is now the Target Corportation."
    "Dayton Dry Goods Company is the original name of Target."
    "In 1966, the first Target stores opened outside of Minnesota."
    "The first Target Distribution Center opened in 1969 in Fridley, MN."
]

false_facts = [
    "Target has 2 million stores in the United States"
    "Target has 50 distribution centers in the United States"
    "Target has approximately 1,000,000 team members worldwide"
    "The median age of Target’s guest is 25"
    "The median household income of Target’s guests is $124,000"
    "Target’s purpose and beliefs slogan is 'We fuel the needs and fulfill the potential of our guests'"
    "Michael McNamara is the Board Chairman and CEO of Target"
    "Brian Cornell is the CIO of Target"
    "The first Target opened in 1902 in Roseville, MN"
    "Target team members wear Red and White"
    "Bullseye became the official ambassador of Target in 1950"
    "Don Draper is the founder of what is now the Target Corporation"
    "Target Dry Goods is the original name of Target"
    "In 1984, the first Target stores opened outside of Minnesota"
]


truthiness = undefined

module.exports = (robot) ->

  robot.respond /target ?fact/i, (message) ->
    truthiness = message.random truthiness_values


    if truthiness
      message.send message.random true_facts
    else
      message.send message.random false_facts


  robot.respond /(true|false)/i, (message) ->
    if truthiness && (message.match[1] == 'true')
      message.reply "Correct! It is true!"
    else if truthiness
      message.reply "No! It was actually true!"
    else if ! truthiness && (message.match[1] == 'false')
      message.reply "Correct! It's false!"
    else
      message.reply "No! That was actually false!"
