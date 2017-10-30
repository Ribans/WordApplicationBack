require 'bundler/setup'
Bundler.require
require "sinatra/reloader" if development?
require "pry" if development?
require "./models"

not_found do
  {error: 404}.to_json
end

get '/auth' do
  erb :"auth/login", :layout => :"layout/default"
end

