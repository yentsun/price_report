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

    it 'parses a simple milk title', (done) ->
        product.parse
            title: 'Молоко Great Milk 3% 1L'
        , (error, data) ->
                assert.equal data.origin, 'Молоко Great Milk 3% 1L'
                assert.equal data.title, 'молоко great milk'
                assert.equal data.package.amount, 1
                assert.equal data.package.unit, "l"
                assert.equal data.percentage, 3
                do done

    it 'parses a milk title with spec chars', (done) ->
        product.parse
            title: 'МОЛОКО БИОСНЕЖКА 2.5% п\п 900гр'
        , (error, data) ->
                assert.equal data.origin, 'МОЛОКО БИОСНЕЖКА 2.5% п\п 900гр'
                assert.equal data.title, 'молоко биоснежка п\п'
                assert.equal data.package.amount, 900
                assert.equal data.package.unit, "g"
                assert.equal data.percentage, 2.5
                do done

    it 'parses a milk title with percentage range', (done) ->
        product.parse
            title: 'Молоко Простоквашино отборное пастеризованное 3,4-4,5%, 0,93л'
        , (error, data) ->
                assert.equal data.package.amount, 0.93
                assert.equal data.package.unit, "l"
                assert.equal data.percentage[0], 3.4
                assert.equal data.percentage[1], 4.5
                do done

    it 'parses a messy milk title', (done) ->
        product.parse
            title: 'Молоко пастериз.1% 1л Лосево'
        , (error, data) ->
                assert.equal data.package.amount, 1
                assert.equal data.package.unit, "l"
                assert.equal data.percentage, 1
                do done
