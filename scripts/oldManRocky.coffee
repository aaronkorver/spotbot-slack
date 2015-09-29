# Description:
#   Save Rocky some typing when he wants to assert seniority
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot old man rocky [person] => random Old Man Rocky quote

# Author:
#   Greg Case

createMeme = require('./lib/img-flip')

old_tech_tasks = [
   'writing cobol code'
   'creating thick client applets'
   'generating endpoints from WSDL'
   'listening to metal'
   'f@@oking with ASP and JdbcTemplate'
   'writing prepared statements'
   'pirating floppy disks'
   'using my palm pilot'
   'buying my first cordless phone'
   'converting Vectors to ArrayLists'
   'downloading IBM VisualAge'
   'writing Struts applications'
   'using GridBagLayout'
   'using tables for layout'
   'drinking beers'
   'listening to bro country'
   'talking about design patterns'
   'writing OO JavaScript'
   'fixing Y2K bugs'
   'rocking Perl CGI'
   'holding forth on the superiority of Smalltalk'
]

young_kid_tasks = [
   'playing hopscotch in the driveway'
   'tasting glue in art class'
   'learning to wipe their ass'
   'asking dad to remove the training wheels'
   'trying to climb out of their crib'
   'listening to N-Sync'
   'watching Teenage Mutant Ninja Turles'
   'learning to count to 5'
   'building pillow forts and crying about their broken GI Joes'
   'asking mommy for more fruit snacks'
   'sitting on Santa\'s lap'
   'trying to convince people that their peach fuzz was actually a beard'
   'squeezing their pimples in the mirror'
   'stroking their baby blankie'
   'wearing training pants'
   'waiting for a diaper change'
]

module.exports = (robot) ->
    robot.respond /old man rocky(.*)?/i, (msg) ->
        youngin = msg.match[1]?.trim()
        old_tech_task = old_tech_tasks[random_index(old_tech_tasks)]
        young_kid_task = young_kid_tasks[random_index(young_kid_tasks)]
        if (!youngin | youngin is 'me')
          youngin = msg.message.user.name

        topText = "I was #{old_tech_task} back when #{youngin} was #{young_kid_task}"

        createMeme(msg, 46284733, topText, "")

random_index = (array) ->
  Math.floor(Math.random() * array.length)
