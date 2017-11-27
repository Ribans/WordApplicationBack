require 'securerandom'

post '/sign_in' do
  content_type :json, :charset => 'utf-8'
  response.headers['Access-Control-Allow-Origin'] = '*'

  params = JSON.parse(request.body.read)
  p user = User.find_by(name: params["username"])

  if user && user.authenticate(params["password"])
    status 200
    {
      profile: {
        username: user.name,
        uid: user.uid
      }
    }.to_json
  else
    status 400
    {message: "パスワードまたはユーザー名に誤りがあります"}.to_json
  end
end

post '/sign_up' do
  content_type :json, :charset => 'utf-8'
  response.headers['Access-Control-Allow-Origin'] = '*'
  params = JSON.parse(request.body.read)
  user = User.new(
    name:     params["username"],
    password: params["password"],
    uid:      SecureRandom.hex(13),
    provider: "original"
  )
  if user.save
    status 200
    {
      profile: {
        username: user.name,
        uid: user.uid
      }
    }.to_json
  else
    status 500
    {message: user.errors.full_messages }.to_json
  end
end
