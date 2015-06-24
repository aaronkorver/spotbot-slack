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
#   spotbot what are you thinking? - Grabs a random title from reddit.com/r/showerthoughts
#
# Author:
#   Matthew Dordal

module.exports = (robot) ->
  robot.respond /what are you thinking\?/i, (msg) ->
    showerThoughts msg

# Check the array for items that are safe.
findThought = (arr, prop) ->
  i = Math.floor(Math.random() * arr.length)
  item = arr[i].data;

  if arr.length == 0
    return 'Nothing really.'

  # Keep calm and find another item
  else if item[prop] == true
    arr.splice i, 1
    return findThought(arr, prop)

  else
    return item.title

showerThoughts = (msg) ->
  url = "http://www.reddit.com/r/showerthoughts.json"

  msg
    .http(url)
      .get() (err, res, body) ->
        response = JSON.parse(body)
        if response.error?
          msg.send "Something went wrong... [http response #{posts.error}]"
          return

        collection = response.data.children
        thought = findThought(collection, 'over_18')
        msg.send thought


