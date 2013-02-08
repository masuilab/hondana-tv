Hondana TV
==========
controll hondana.org with goldfish

* http://hondana-tv.herokuapp.com/
* https://github.com/masuilab/hondana-tv


Install Dependencies
--------------------
requirements

* Ruby 1.8.7+ or 1.9.2+
* memcached


    % brew install memcached
    % gem install bundler foreman
    % bundle install


Run
---

    % cp sample.config.yml config.yml
    % memcached -vv -p 11211 -U 11211
    % foreman start

=> http://localhost:5000


Deploy
------

    % heroku create --stack cedar

add memcache addon

    % heroku addons:add memcache:5mb
or
    % heroku addons:add memcachier:dev

contents_navi config

    % heroku config:set CONTENTS_NAVI_USER=username
    % heroku config:set CONTENTS_NAVI_PASS=password

deploy

    % git push heroku master
    % heroku open
