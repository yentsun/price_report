register = require './cmd/register'

module.exports = (options) ->
    seneca = @
    role = 'price_report'

    seneca.add "role:#{role},cmd:register", register seneca, options
    role