# Ankimo Server
> 
Ribans Project

## Build Setup

~~~
$ touch .env # create env file

#install for packages
$ docker-compose run web bundle install -j4 --path vendor/bundle

# setup databse
$ docker-compose run web bundle exec rake db:setup

# launch server
$ docker-compose up
~~~
