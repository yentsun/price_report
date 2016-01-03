assert = require 'chai'
    .assert

options =
    test: true

log_mode = process.env.TEST_LOG_MODE or 'quiet'
seneca = require('seneca')(
    log: log_mode
)
.use '../product', options

product = seneca.pin
    role: 'product'
    cmd: '*'

describe 'parse', () ->

    it 'parses product package', (done) ->
        product.parse
            title: 'Great Milk three 1L'
        , (error, data) ->
                assert.equal data.package, '1 l'
                do done