# setup script for Chartup project
# Works on fresh DigitalOcean Ubuntu 12.04.3 x64 droplet
sudo apt-get update
sudo apt-get install curl nodejs libpq-dev git emacs23-nox lilypond

#Install RVM. Use Ruby 2.1.1
\curl -L https://get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm
rvm install 2.1.1
rvm use 2.1.1
rvm --default 2.1.1

echo "gem: --no-document" >> ~/.gemrc

#Update default gems
rvm gemset use global
gem update


#Install Rails 4.1
rvm use ruby-2.1.1@rails4.1 --create
gem install rails --version=4.1

#Set up Chartup project
ssh-keygen -t rsa -C "arthur.lewis@gmail.com"
eval "$(ssh-agent)"
ssh-add ~/.ssh/id_rsa
# Make sure to add SSH key to Github
git clone git@github.com:arthurthefourth/chartup_rails.git
cd chartup_rails
bundle install
RAILS_ENV=production rake db:create db:schema:load
bundle exec rails server -e production

