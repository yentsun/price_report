PEG = require 'pegjs'
fs = require 'fs'
path = require 'path'

module.exports = (seneca, options) ->

    cmd_parse = (args, respond) ->
        path_to_grammar = path.join __dirname, 'PTP.peg'
        grammar = fs.readFileSync path_to_grammar,
            encoding: 'utf-8'
        parser = PEG.buildParser grammar
        objects = parser.parse do args.title.toLowerCase
        result =
            origin: args.title
            words: []
        for object in objects
            if 'word' of object
                result.words.push object.word
            if 'package' of object
                result.package = object.package
            if 'percentage' of object
                result.percentage = object.percentage
        result.title = result.words.join ' '
        respond null, result

    cmd_parse