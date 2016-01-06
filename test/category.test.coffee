assert = require 'chai'
.assert

options =
    test: true

log_mode = process.env.TEST_LOG_MODE or 'quiet'
seneca = require('seneca')(
    log: log_mode
)
.use '../category', options

category = seneca.pin
    role: 'category'
    cmd: '*'

describe 'get', () ->

    it 'returns category info from datamap', (done) ->
        category.get
            id: 'milk'
        , (error, category) ->
            assert.equal category.title, 'milk'
            assert.include category.keyword, 'молоко'
            do done

    it 'returns null if data was found', (done) ->
        category.get
            id: 'abracadabra'
        , (error, category) ->
            assert.isNull category
            do done