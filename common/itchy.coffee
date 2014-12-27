"use strict"

fs        = require "fs"

CHARS     = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-_'
FILE_NAME = "oizio-itchy.json"

module.exports =

  generate: (length = 7) ->
    shortcut = for [1..length]
      CHARS.charAt(Math.floor(Math.random() * CHARS.length))
    shortcut.join('')

  store: ->
    try
      @file = JSON.parse(fs.readFileSync(FILE_NAME, 'utf-8'))
    catch e
      @file = {}

  get: (key) ->
    @file[key]

  set: (key, attributes) ->
    @file[key] = attributes
    fs.writeFileSync FILE_NAME, JSON.stringify(@file)
