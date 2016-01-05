validator = require 'validator'

module.exports = (seneca, options) ->

    cmd_parse = (args, respond) ->
        parser = options.parser
        title = validator.trim do args.title.toLowerCase
        objects = parser.parse title

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
