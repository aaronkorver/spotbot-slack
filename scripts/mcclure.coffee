# Description:
#   Hi, I'm Troy McClure! You may remember me from...
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot mcclure => random Troy McClure appearance

# Author:
#   maxthyen


motivationalVideos = [
  "David versus Super Goliath"
  "60 Minutes of Car Crash Victims"
  "Adjusting Your Self-O-Stat"
  "The Decapitation of Larry Leadfoot"
  "Dig Your Own Grave and Save"
  "Earwigs, Ew!"
  "Firecrackers: The Silent Killer"
  "Fuzzy Bunny's Guide to You-Know-What"
  "Get Confident, Stupid!"
  "The Half-Assed Approach to Foundation Repair"
  "Here Comes the Metric System"
  "Lead Paint: Delicious But Deadly"
  "Locker Room Towel Fights: The Blinding of Larry Driscoll"
  "Man Versus Nature: The Road To Victory"
  "Mommy, What's Wrong With That Man's Face?"
  "Mothballing Your Battleship"
  "Phony Tornado Alerts Reduce Readiness"
  "Smoke Yourself Thin"
  "Someone's in the Kitchen with DNA!"
  "Two Minus Three Equals Negative Fun"
]

films = [
  "The Boatjacking of Supership '79"
  "Calling All Quakers"
  "The Contrabulous Fabtraption of Professor Horatio Hufnagel"
  "David versus Super Goliath"
  "Dial M for Murderousness"
  "The Erotic Adventures of Hercules"
  "Give My Remains to Broadway"
  "Gladys the Groovy Mule"
  "Good-Time Slim, Uncle Doobie, and the Great 'Frisco Freak-Out'"
  "The Greatest Story Ever Hulaed"
  "Here Comes the Coast Guard"
  "Hydro, the Man With the Hydraulic Arms"
  "Leper in the Backfield"
  "The Muppets Go Medieval"
  "'P' is for Psycho"
  "Preacher With a Shovel"
  "The President's Neck is Missing"
  "The Revenge of Abe Lincoln"
  "Sorry, Wrong Closet"
  "Suddenly Last Supper"
  "They Came to Burgle Carnegie Hall"
  "The Verdict Was Mail Fraud"
  "The Wackiest Covered Wagon in the West"
  "Look Who's Still Oinking"
]

module.exports = (robot) ->
    robot.respond /mcclure/i, (msg) ->
        msg.reply("You may remember me from such films as \"#{ msg.random motivationalVideos }\" and \"#{ msg.random films }\".")
