# -*- encoding: utf-8 -*-

get '/learn' do #覚えるパート(暗記)
  content_type :json, :charset => 'utf-8'
  response.headers['Access-Control-Allow-Origin'] = '*'

  # user = User.find_by(uid: session[:uid])
  # words = user.words.where(category: (0..4).to_a.sample).sample(5)
  words = Word.all.sample(5)
  @data = Array.new
  words.each do  |word|
    @data << {
      id: word.id, 
      japanese: word.japanese, 
      english: word.english
    }
  end

  @data.to_json
end

get '/challenge' do  #チャレンジパート(実力)
  content_type :json, :charset => 'utf-8'
  response.headers['Access-Control-Allow-Origin'] = '*'

  user = User.find_by(uid: session[:uid])
  word = user.words.where(category: (0..4).to_a.sample).sample
  exam = make_exam(word)
  exam[:dummies] += make_dummmy(word, :random)
  exam.to_json
end


get  '/training' do #トレーニング
  content_type :json, :charset => 'utf-8'
  response.headers['Access-Control-Allow-Origin'] = '*'

  if user = User.find_by(uid: session[:uid])
    if user.words.count >= 4
      word = user.words.sample
      exam = make_exam(word).to_json
      exam[:dummies] += make_dummmy(word, :user)
      exam.to_json
    else
      {status: 401, message: "もっと勉強しましょう"}
    end
  else
    {status: 401, message: "ログインしてください"}
  end
end

post '/remembered' do
  content_type :json, :charset => 'utf-8'
  response.headers['Access-Control-Allow-Origin'] = '*'

  begin
  WordThatTheUserLearned.find_or_create_by(user_id: params["user_id"], word_id: ["word_id"])
  {status: 200}.to_json
  rescue
  {status: 500}.to_json
  end
end

post '/forgot' do
  content_type :json, :charset => 'utf-8'
  response.headers['Access-Control-Allow-Origin'] = '*'

  begin
  wl = WordThatTheUserLearned.find_by(user_id: params["user_id"], word_id: ["word_id"])
  wl.destroy
  {status: 200}.to_json
  rescue
  {status: 500}.to_json
  end
end

get '/tank-rate' do
  content_type :json, :charset => 'utf-8'
  response.headers['Access-Control-Allow-Origin'] = '*'

  user = User.find_by(uid: session[:uid])
  binding.pry
  a,b,c = 0,0,0
  user.words.each do |w|
    case w.category
    when 0 then a+=1
    when 1 then b+=1
    when 2 then c+=1
    end
  end
  {"動詞":   {base: Word.where(category: 0).count, learned: a},
   "名詞":   {base: Word.where(category: 1).count, learned: b},
   "接続詞": {base: Word.where(category: 2).count, learned: c},
  }.to_json
end

private

def make_exam(word)
  if word
    dummies = [{ japanese: word.japanese, english: word.english }]
    @data = {
      id: word.id,
      japanese: word.japanese,
      english: word.english,
      dummies: dummies
    }
  else
    @data = {error: "学習単語なし"}
  end
  return @data
end

def make_dummmy(word, method)
  ary  = []
  if method == :random
    words = Word.where( category: word.category ).sample(3)
  else
    words = User.find_by(session: session[:uid]).words.where( category: word.category  ).sample(3)
  end
  words.each { |w| ary << {japanese: w.japanese, english: w.english} }
  return ary
end


