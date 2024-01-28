require 'sinatra'

get '/' do
  "<h1>Hello World</h1>"
end

get '/whatever' do
  erb :whatever   #erb = embedded ruby
end

get '/form' do
  erb :form
end

post '/form' do
  @name = "#{params[:post][:first_name]} #{params[:post][:last_name]}"
  puts @name
  @name
end

get '/:name' do
  @name = params['name']
  erb :hello
end

