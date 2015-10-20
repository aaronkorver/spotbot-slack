# Description:
#   Determines the release date of Half Life 3
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   Half Life 3 - Displays a message saying when Half Life 3 is expected to be released.

# Author:
#   Matthew Dordal

months = {
  Jan: 1,
  Feb: 2,
  Mar: 3,
  Apr: 4,
  May: 5,
  Jun: 6,
  Jul: 7,
  Aug: 8,
  Sep: 9,
  Oct: 10,
  Nov: 11,
  Dec: 12
};

module.exports = (robot) ->
  robot.hear /(^|[^\.])\bhalf life 3\b/i, (msg) ->
    if (!robot.brain.get('halfLife3'))
      # set initial date if one is not already set
      d = new Date(4055, 4, 13);

      month = getMonthString d.getMonth()
      day = d.getDate()
      year = d.getFullYear()

      initialDate = {
       month: month,
       day: day,
       year: year
      }

      robot.brain.set 'halfLife3', initialDate
      date = robot.brain.get('halfLife3')
      msg.send getMessage(date)
    else
      date = robot.brain.get('halfLife3')
      incrementDate date

      msg.send getMessage(date)

getMonthString = (num) ->
  return Object.keys(months)[num - 1];

incrementDate = (obj) ->
  str = obj.month + ' ' + obj.day + ', ' + obj.year
  newMonth = getMonthString ( (new Date(str).getMonth() + 1) % 12 ) + 1;

  obj.month = newMonth

  if (newMonth == 'Jan')
    obj.year = obj.year + 1

  robot.brain.set 'halfLife3', obj

getMessage = (date) ->
  message = "Half Life 3 has been mentioned. This reference of Half Life 3 pushes the release date back "
  message += "one month. Half Life 3 will now be released on #{date.month} #{date.day}, #{date.year}"

  return message
