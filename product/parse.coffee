PEG = require 'pegjs'
fs = require 'fs'
path = require 'path'

module.exports = (seneca, options) ->

    cmd_parse = (args, respond) ->
        path_to_grammar = path.join __dirname, 'PTP.peg'
        grammar = fs.readFileSync path_to_grammar,
            encoding: 'utf-8'
        parser = PEG.buildParser grammar
        result = parser.parse args.title
        respond null, result

    cmd_parse