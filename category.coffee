yaml = require 'yamljs'
path = require 'path'
get = require './category/get'

module.exports = (options) ->
    seneca = @
    role = 'category'
    seneca.add "init:#{role}", (args, respond) ->
        path_to_datamap = path.join __dirname, 'category', 'data.yaml'
        datamap = yaml.load path_to_datamap
        options.datamap = datamap
        do respond
    seneca.add "role:#{role},cmd:get", get seneca, options
    role