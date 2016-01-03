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

    it 'fails if price value is invalid', (done) ->
        report.register
            product_title: 'Молоко Great Milk three 1L'
            price_value: 'nope'
            url: 'http://scottys2.com/products/milk/1'
            merchant_id: "Scotty's grocery 2"
            reporter_id: 'Jill'
        , (error, report) ->
            assert.isNull report
            assert.include error.message, 'price value invalid'
            do done

    it 'fails if product title is invalid', (done) ->
        report.register
            product_title: ''
            price_value: '123'
            url: 'http://scottys2.com/products/milk/1'
            merchant_id: "Scotty's grocery 2"
            reporter_id: 'Jill'
        , (error, report) ->
            assert.isNull report
            assert.include error.message, 'product title invalid'
            do done

    it 'fails if merchant id is invalid', (done) ->
        report.register
            product_title: 'Молоко Great Milk three 1L'
            price_value: '123'
            url: 'http://scottys2.com/products/milk/1'
            merchant_id: ""
            reporter_id: 'Jill'
        , (error, report) ->
            assert.isNull report
            assert.include error.message, 'merchant id invalid'
            do done

    it 'fails if reporter id is invalid', (done) ->
        report.register
            product_title: 'Молоко Great Milk three 1L'
            price_value: '123'
            url: 'http://scottys2.com/products/milk/1'
            merchant_id: "Scotty's grocery 2"
            reporter_id: ''
        , (error, report) ->
            assert.isNull report
            assert.include error.message, 'reporter id invalid'
            do done

    it 'fails if url is invalid', (done) ->
        report.register
            product_title: 'Молоко Great Milk three 1L'
            price_value: '123'
            url: ''
            merchant_id: "Scotty's grocery 2"
            reporter_id: 'Jill'
        , (error, report) ->
            assert.isNull report
            assert.include error.message, 'url invalid'
            do done