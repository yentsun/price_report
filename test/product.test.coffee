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
            title: 'Молоко Great Milk 3% 1L'
        , (error, data) ->
                assert.equal data.origin, 'Молоко Great Milk 3% 1L'
                assert.equal data.title, 'молоко great milk'
                assert.equal data.package.amount, 1
                assert.equal data.package.unit, "l"
                assert.equal data.percentage, 3
                do done
