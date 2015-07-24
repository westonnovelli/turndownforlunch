#Turn Down For Lunch
Blackbaud - Off the Grid Summer '14 - revived!

### What is it?
Turn Down For Lunch is a way to decide where the office wants to go to lunch.

Sign in, make a suggestion, and vote for your choice. You can even make suggestions
for future days! You can only vote for each suggestion once, but can vote for more
than one suggestion each day.

### How to run!
1. bundle install
2. rake db:migrate
3. rails server
4. navigate to localhost:3000
5. enjoy!

### Most basic production install I could figure out
1. `bundle exec rake db:migrate RAILS_ENV="production"` make the production db
2. `RAILS_ENV=production bundle exec rake assets:precompile` compile the assets
(The production config is set to find assets that it could not find precompiled
  which is different than the default).
3. `rails server -e production` run the server.
