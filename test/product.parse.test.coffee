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

    it 'parses a composite package title', (done) ->
        product.parse
            title: 'Молоко пастериз.1% 1л + 0,5л Лосево'
        , (error, data) ->
                assert.equal data.package.amount, 1.5
                assert.equal data.package.unit, "l"
                assert.equal data.percentage, 1
                do done

    it 'parses a multi package title', (done) ->
        product.parse
            title: 'Молоко пастериз.1% 12 * 1л Лосево'
        , (error, data) ->
                assert.equal data.package.amount, 12
                assert.equal data.package.unit, "l"
                assert.equal data.percentage, 1
                do done

    it 'parses another multi package title', (done) ->
        product.parse
            title: 'Молоко пастериз.1% 200мл x 4 шт Лосево'
        , (error, data) ->
                assert.equal data.package.amount, 800
                assert.equal data.package.unit, "ml"
                assert.equal data.percentage, 1
                do done

    it 'parses amount range', (done) ->
        product.parse
            title: 'яблоки сезонные 2,3-2,5кг'
        , (error, data) ->
                assert.equal data.package.amount[0], 2.3
                assert.equal data.package.amount[1], 2.5
                assert.equal data.package.unit, "kg"
                assert.isUndefined data.percentage
                do done

    it 'parses amount range with zeroes in floats', (done) ->
        product.parse
            title: 'яблоки сезонные 0,6-0,95кг'
        , (error, data) ->
                assert.equal data.package.amount[0], 0.6
                assert.equal data.package.amount[1], 0.95
                assert.equal data.package.unit, "kg"
                do done

    it 'parses `unitless` package with `pcs` unit', (done) ->
        product.parse
            title: 'Яйцо Окское куриное СВ белое 1х20'
        , (error, data) ->
                assert.equal data.package.amount, 20
                assert.equal data.package.unit, "pcs"
                do done

    it 'parses `word` package with `pcs` unit and with whitespace at the end', (done) ->
        product.parse
            title: 'яйцо окское куриное св десяток белое '
        , (error, data) ->
                assert.equal data.package.amount, 10
                assert.equal data.package.unit, "pcs"
                do done
