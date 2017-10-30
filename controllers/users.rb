get '/sign_in' do
  erb :"users/sign_in"
end

get '/sign_up' do
  erb : "users.sign_up"
end

post '/sign_up' do
end

get '/sign_out' do
  redirect '/'
end
