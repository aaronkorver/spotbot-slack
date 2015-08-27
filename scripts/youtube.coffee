# Description:
#   Responds to youtube requests with the first relevant video.
#   Updated to use the Youtube V3 API
#
# Configuration:
#   HUBOT_YOUTUBE_API_KEY
#
# Commands:
#   hubot (youtube|yt) [me] <query> - Searches YouTube for the query and returns the video link.
module.exports = (robot) ->
  # Grab the api key
  api_key = process.env.HUBOT_YOUTUBE_API_KEY

  # On initialization, if we couldn't find the key, we should log a warning
  unless api_key?
    robot.logger.warning "The HUBOT_YOUTUBE_API_KEY environment variable not set"

  robot.respond /(youtube|yt)( me)? (.*)/i, (msg) ->
    # If we don't have the api key, there's no reason to progress
    # Send an error message to the room and return
    unless api_key?
      msg.send "Could not read the HUBOT_YOUTUBE_API_KEY value. Please contact the bot administrator."
      return

    query = msg.match[3]
    robot.http("https://www.googleapis.com/youtube/v3/search")
      .query({
        part: 'snippet'
        key: api_key
        maxResults: 1
        q: query
        type: 'video'
      })
      .get() (err, res, body) ->
        results = JSON.parse(body)
        # If the results don't contain videos, we don't want to crash
        if results.items && results.items[0]
          videoID = results.items[0].id.videoId

        # If we don't have a videoID, send an error to the room
        unless videoID?
          msg.send "No video results for \"#{query}\" :("
          return

        msg.send "https://www.youtube.com/watch?v=#{videoID}"
