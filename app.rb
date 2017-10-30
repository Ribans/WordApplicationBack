require 'bundler/setup'
Bundler.require
# require "sinatra"
# require "sinatra/base"
# require "sinatra/reloader"
require "pry" if development?
# require "json"
require "./models"

not_found do
  {error: 404}.to_json
end

get '/' do
  "Helloworld"
end

