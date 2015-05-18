# Description:
#   Creates a reminder for a given time.
#
# Dependencies:
#   "moment": "2.10.2"
#
# Configuration:
#   None
#
# Commands:
#   hubot remind (me|us) to <reminder> at <time>
#   hubot remind (me|us) to <reminder> at <time> on <date>
#   hubot remind (me|us) to <reminder> on <date> at <time>
#   hubot remind (me|us) to <reminder> in <time amount> <time denomination>
#
# Examples:
#   hubot remind us to get up and strech at 11:12 AM
#   hubot remind us to get up and strech at 11:12:13
#   hubot remind us to get up and strech at 11:12 on 04-05-2015
#   hubot remind me to buy milk in 3 hours
#   hubot remind me to buy milk in 2 days
#
# Author:
#   A person that writes things.
#

# Create the API client
moment = require("moment");


#
# Sets reminder when given a specific time
#
remindAt = (res, reminder, time, date) ->
  now = moment();

  # Check for a supplied date. If there isn't, default it.
  # Moment then tries to match the best format for the date
  date = now.format("YYYY-MM-DD") if (!date);
  date = moment(date, ["MM-DD-YYYY", "DD-MM-YYYY", "YYYY-MM-DD"]);

  # Check for AM or PM
  meridiem = now.format("a");
  match = RegExp(/(AM|PM)/ig).exec(time);
  time += " " + meridiem if (!match);
  
  # Get the moment of the time the specify. Then, diff it from now.
  date_str = date.format("YYYY-MM-DD") + " " + time;
  reminder_time = moment(date_str);
  ms = reminder_time.diff(now, "milliseconds", true);

  # Set reminder
  setReminder res, reminder, ms


#
# Remind me in a future amount of time. Adds a duration.
# 
remindIn = (res, reminder, time_quantity, time_units) ->
  now = moment();

  # Find time
  reminder_time = moment().add(moment.duration(parseInt(time_quantity), time_units));
  ms = reminder_time.diff(now, "milliseconds", true);

  # Set reminder
  setReminder res, reminder, ms


#
# Uses setTime to schedule a reminder
#
setReminder = (res, reminder, ms) ->
  res.reply "A reminder has been created for you.";
  setTimeout () ->
    res.reply reminder
  , ms


#
# Hooks
#
module.exports = (robot) ->
  robot.respond /remind (me|us) to (.+) at (.+)/i, (res) ->
    reminder = res.match[2]
    time = res.match[3]
    remindAt res, reminder, time

  robot.respond /remind (me|us) to (.+) at (.+) on (.+)/i, (res) ->
    reminder = res.match[2]
    time = res.match[3]
    date = res.match[4]
    remindAt res, reminder, time, date

  robot.respond /remind (me|us) to (.+) on (.+) at (.+)/i, (res) ->
    reminder = res.match[2]
    date = res.match[3]
    time = res.match[4]
    remindAt res, reminder, time, date

  robot.respond /remind (me|us) to (.+) in (.+) (.+)/i, (res) ->
    reminder = res.match[2]
    time_amount = res.match[3]
    time_duration = res.match[4]
    remindIn res, reminder, time_amount, time_duration

