# Description:
#   Time to drop the hammer.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   enterpise - drop the enterprise hammer
#   java - drop the java hammer
#   spring mvc - drop the spring mvc hammer
#
# Author:
#   dak

module.exports = (robot) ->
	robot.hear /enterprise hammer/i, (msg) ->
	message.send "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/QcPuGKRGKm2Q71u/enterprise-hammer.gif"

	robot.hear /spring hammer/i, (message) ->
	message.send "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/huEU4xNgrxRDVNX/spring-mvc-hammer.gif"

	robot.hear /java hammer/i, (message) ->
	message.send "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/6drhKpChH2BWrUq/java-hammer.gif"