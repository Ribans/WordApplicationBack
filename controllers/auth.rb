
get '/auth' do
  erb :"auth/login", :layout => :"layout/default"
end
