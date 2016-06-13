# Description:
#   Track Helpful Links for users
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot link add [name] [link] - store a link
#   hubot link rename [name] [new name] - rename stored link
#   hubot link rm [name] - remove a stored link by name
#   hubot link get [name] - get a stored link
#   hubot link ls - list all stored links
#
# Author:
#  jordangoetze
#

class UserDetails
    constructor:  ->
        @links = {}


class LinkStorage
    constructor: (@robot) ->
        @users= {}

        @robot.brain.on 'loaded', =>
            @links = @robot.brain.data.links || {}

    save: ->
        @robot.brain.data.links = @links

    getUser: (user) ->
        result = @users[user]
        if(!result)
            result = new UserDetails()
            @users[user] = result
        result

    add: (user, name, link) ->
        userDetails = @getUser(user)
        userDetails.links[name] = link
        @users[user] = userDetails
        @save()

    rm: (user, name) ->
        userDetails = @getUser(user)
        delete userDetails.links[name]
        @users[user] = userDetails
        @save()

    ls: (user) ->
        userDetails = @getUser(user)
        output = user + "'s links:\n"
        for link in Object.keys(userDetails.links)
            output = output + " " + link + "\n"
        output

    get: (user, name) ->
        userDetails = @getUser(user)
        result = userDetails.links[name]
        if(!result)
            output = "No link named: " + name + "."
        else
            output = result
        output


module.exports = (robot) ->
    linkStorage = new LinkStorage robot

    robot.respond /link ls/i, (msg) ->
        output = linkStorage.ls(msg.message.user.name)
        msg.send output

    robot.respond /link add (.*) (.*)/i, (msg) ->
        output = linkStorage.add(msg.message.user.name, msg.match[1], msg.match[2])
        msg.send "Link #{msg.match[1]} added."

    robot.respond /link rm (.*)/i, (msg) ->
        output = linkStorage.rm(msg.message.user.name, msg.match[1])
        msg.send "Link #{msg.match[1]} removed."

    robot.respond /link get (.*)/i, (msg) ->
        output = linkStorage.get(msg.message.user.name, msg.match[1])
        msg.send output


