# README

## Installation

	git clone REPO

### rvm
	\curl -sSL https://get.rvm.io | bash -s stable
	rvm install 2.6.0
	rvm use 2.6.0

### bundler
	gem install bundler

### yarn
	brew install yarn --without-node
	yarn install

### gems
	bundle install --without production


### database.yml
save as config/database.yml
```
development:
	adapter: sqlite3
	database: db/development.sqlite3
	pool: 5
	timeout: 5000


test:
	adapter: sqlite3
	database: db/test.sqlite3
	pool: 5
	timeout: 5000
```

	rake db:create
	rake db:migrate

### run dev server
	rails s



	
