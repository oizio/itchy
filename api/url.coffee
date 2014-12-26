"use strict"

Hope    = require("zenserver").Hope
fs      = require "fs"

module.exports = (server) ->

  server.get "/shortcut", (request, response) ->
    if request.required ['url']
      url = request.parameters.url

      json = tryRead('itchy.json') or {}
      itchy_id = itchy() while !itchy_id? or itchy_id in json
      json[itchy_id] = url
      fs.writeFileSync 'itchy.json', JSON.stringify(json)
      response.json
        "url"   : url
        "itchy" : itchy_id

  server.get "/:itchy_id", (request, response) ->
    json = tryRead("itchy.json") or {}
    console.log json
    response.json "url": json[request.parameters.itchy_id]

# -- Private Methods -----------------------------------------------------------
tryRead = (filename) ->
  try JSON.parse(fs.readFileSync(filename, 'utf-8'))

itchy = (length = 7) ->
  allowedChars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-_'
  id = for [1..length]
    allowedChars.charAt(Math.floor(Math.random() * allowedChars.length))
  id.join('')
