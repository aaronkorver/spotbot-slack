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
old_tech_task = [
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
]

young_kid_task = [
   'playing hopscotch in the driveway'
   'tasting glue in art class'
   'learning to wipe their ass'
   'asking dad to remove the training wheels'
   'trying to climb out of their crib'
   'listening to N-Sync'
   'watching Teenage Mutant Ninja Turles'
   'learning to count to 5'
   'building pillow forts and crying about his broken GI Joes'
   'asking mommy for more fruit snacks'
   'sitting on Santa\'s lap'
   'trying to convince people that your peach fuzz was actually a beard'
]

module.exports = (robot) ->
    robot.respond /old man rocky(.*)?/i, (msg) ->
        youngin = msg.match[1]?.trim()
        verb = 'was'
        if (!youngin)
          youngin = 'you'
          verb = 'were'

        msg.send("(rocky) says \"I was #{ msg.random old_tech_task } back when #{youngin} #{verb} #{ msg.random young_kid_task }.\"")
