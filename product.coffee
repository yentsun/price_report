parse = require './product/parse'

module.exports = (options) ->
    seneca = @
    role = 'product'

    seneca.add "role:#{role},cmd:parse", parse seneca, options
    role