PEG = require 'pegjs'
path = require 'path'
fs = require 'fs'
parse = require './product/parse'

module.exports = (options) ->
    seneca = @
    role = 'product'
    seneca.add "init:#{role}", (args, respond) ->
        path_to_grammar = path.join __dirname, 'product', 'PTP.peg'
        grammar = fs.readFileSync path_to_grammar,
            encoding: 'utf-8'
        options.parser = PEG.buildParser grammar
        do respond
    seneca.add "role:#{role},cmd:parse", parse seneca, options
    role