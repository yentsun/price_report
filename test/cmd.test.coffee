assert = require 'chai'
    .assert
moment = require 'moment'

log_mode = process.env.TEST_LOG_MODE or 'quiet'

options =
    test: true

seneca = require('seneca')(
    log: log_mode
)
.use '../plugin', options


report = seneca.pin
    role: 'price_report'
    cmd: '*'

describe 'register', () ->

    it 'registers a new price report', (done) ->
        report.register
            product_title: 'Молоко Great Milk three 1L'
            price_value: '42.6'
            url: 'http://scottys2.com/products/milk/1'
            merchant_id: "Scotty's grocery 2"
            reporter_id: 'Jill'
        , (error, report) ->
            assert.equal report.product_title, 'Молоко Great Milk three 1L'
            assert.equal report.price_value, 42.6
            assert.equal report.url, 'http://scottys2.com/products/milk/1'
            assert.equal report.merchant_id, "Scotty's grocery 2"
            assert.equal report.reporter_id, 'Jill'
            assert.equal report.date_time, do moment().format # TODO not to rely upon
            do done