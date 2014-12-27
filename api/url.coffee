"use strict"

fs        = require "fs"
Hope      = require("zenserver").Hope
itchy     = require "../common/itchy"
shortcuts = itchy.store()
console.log "shortcuts", shortcuts

module.exports = (server) ->

  server.get "/shortcut/generate", (request, response) ->
    if request.required ['url']
      url = request.parameters.url
      key = itchy.generate() while !key? or key in shortcuts
      itchy.set key,
        url   : url
        views : 0
      response.json
        "url"   : url
        "itchy" : "http://#{key}"

  server.get "/:shortcut", (request, response) ->
    shortcut_key = request.parameters.shortcut
    shortcut = shortcuts[shortcut_key]
    if shortcut
      shortcut.views += 1
      itchy.set shortcut_key, shortcut
      response.redirect shortcut.url
    else
      response.json "itchy": "not found"
