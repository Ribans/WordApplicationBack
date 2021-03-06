require 'bundler/setup'
Bundler.require
require 'net/http'
require 'uri'
require 'json'

config  = YAML.load_file( './database.yml' )

ActiveRecord::Base.configurations = config
if development?
  ActiveRecord::Base.establish_connection(config["development"])
else
  ActiveRecord::Base.establish_connection(config["production"])
end

Time.zone = "Tokyo"
ActiveRecord::Base.default_timezone = :local

after do
  ActiveRecord::Base.connection.close
end

class Word < ActiveRecord::Base
  has_many :word_that_the_user_learneds
  has_many :users, :through => :word_that_the_user_learneds
end

class User < ActiveRecord::Base
  has_many :word_that_the_user_learneds
  has_many :words, :through => :word_that_the_user_learneds

  validates :name, presence: true
  validates :password_digest, presence: true
  has_secure_password
end

class WordThatTheUserLearned < ActiveRecord::Base
  validates :user_id, presence: true
  validates :word_id, presence: true
  belongs_to :user
  belongs_to :word
end
