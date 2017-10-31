get '/sign_in' do
  erb :"users/sign_in", :layout => :"layout/default"
end

get '/sign_up' do
  erb :"users/sign_up", :layout => :"layout/default"
end

post '/sign_up' do
end

get '/sign_out' do
  redirect '/'
end
