# setup for Chartup project
# Works on fresh DigitalOcean Ubuntu 12.04.3 x64 droplet
# Not to be run as full script
sudo apt-get update
sudo apt-get install curl nodejs libpq-dev git emacs23-nox libcurl4-openssl-dev

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
# (Make sure to add SSH key to Github)
git clone git@github.com:arthurthefourth/chartup_rails.git
cd chartup_rails
bundle install

#Lilypond
curl -O http://download.linuxaudio.org/lilypond/binaries/linux-64/lilypond-2.18.2-1.linux-64.sh
sudo sh lilypond-2.18.2-1.linux-64.sh
# Nginx and Passenger

# If machine has low RAM
	# sudo dd if=/dev/zero of=/swap bs=1M count=1024
	# sudo mkswap /swap
	# sudo swapon /swap

gem install passenger
rvmsudo passenger-install-nginx-module

# Download nginx startup script
wget -O init-deb.sh http://library.linode.com/assets/660-init-deb.sh

# Move the script to the init.d directory & make executable
sudo mv init-deb.sh /etc/init.d/nginx
sudo chmod +x /etc/init.d/nginx

# Add nginx to the system startup
sudo /usr/sbin/update-rc.d -f nginx defaults
sudo service nginx start 

#Configure nginx in /opt/nginx/nginx.conf
	# server { 
	# listen 80; 
	# server_name example.com; 
	# passenger_enabled on; 
	# root /var/www/my_awesome_rails_app/public; 
	# }

mkdir downloads
# Deploy secrets.yml somehow

#In production
RAILS_ENV=production rake db:create db:schema:load
RAILS_ENV=production bundle exec rake assets:precompile
#bundle exec rails server -e production

