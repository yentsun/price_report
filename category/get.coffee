traverse = require 'traverse'
validator = require 'validator'

module.exports = (seneca, options) ->

    cmd_get = (msg, respond) ->
        datamap = options.datamap
        id = validator.trim do msg.id.toLowerCase
        result = null
        traverse(datamap).forEach (node_value) ->
            node = @
            if node.key == id
                result = node_value
                # TODO if we only could `break` here
        respond null, result
    cmd_get