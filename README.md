Hondana TV
==========
controll hondana.org with goldfish

* http://hondana-tv.herokuapp.com/
* https://github.com/masuilab/hondana-tv


Install Dependencies
--------------------
Ruby 1.8.7+ or 1.9.2+ required.

    % gem install bundler foreman
    % bundle install


Run
---

    % foreman start

=> http://localhost:5000


Deploy
------

    % heroku create --stack cedar
    % git push heroku master
    % heroku open
