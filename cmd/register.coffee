validator = require 'validator'
moment = require 'moment'
uuid = require 'uuid'

module.exports = (seneca, options) ->

    cmd_register = (args, respond) ->
        try
            price_value = validator.toFloat args.price_value
            throw new Error 'price value invalid' if not validator.isFloat price_value

            product_title = validator.trim args.product_title
            seneca.log.debug 'product title is', product_title
            throw new Error 'product title invalid' if not product_title

            merchant_id = validator.trim args.merchant_id
            throw new Error 'merchant id invalid' if not merchant_id

            reporter_id = validator.trim args.reporter_id
            throw new Error 'reporter id invalid' if not reporter_id

            url = validator.trim args.url
            throw new Error 'url invalid' if not url

            sku = validator.trim args.sku

        catch error
            seneca.log.error 'new report failed:', error.message
            respond error, null

        seneca.make 'price_report',
            uuid: do uuid.v4
            price_value: price_value
            product_title: product_title
            merchant_id: merchant_id
            reporter_id: reporter_id
            url: url
            sku: sku
            date_time: do moment().format
        .save$ (error, saved_report) ->
            respond error, saved_report


    cmd_register
