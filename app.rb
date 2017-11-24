require 'bundler/setup'
Bundler.require
require "sinatra/reloader" if development?
require "pry" if development?
require "./models"
require "./controllers/users"
require "./controllers/api"

not_found do
  {error: 404}.to_json
end

