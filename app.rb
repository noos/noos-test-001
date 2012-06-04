require 'sinatra'
require 'sinatra/mhaml'

get '/' do
  haml :index
end
