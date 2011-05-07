## setup

### checkout
  
  git clone -o heroku git@heroku.com:beatbox.git

  cd beatbox

  git remote add origin git@github.com:topspin/beatbox.git

  git pull origin master

#### push to github

  git push origin

#### heroku deploy

  git push heroku

### rebundle

  bundle install --binstubs --without production staging

### launch console

  bundle exec script/console

### launch server

  bundle exec script/server

### running tests

   bundle exec script/spec spec

