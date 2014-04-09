.PHONY: test

setup:
	echo APP_KEY=$$(basename $$(pwd)) >> env.sh
	echo APP_SECRET=$$(make secret | grep -v 'ruby') >> env.sh
	echo DATABASE_URL=postgres://user:pass@host/ready4rails4
	command -v gs  || gem install gs
	command -v dep || gem install dep
	command -v shotgun || gem install shotgun

console:
	env $$(cat env.sh) irb -r ./app.rb

migrate:
	env $$(cat env.sh) sequel -m ./migrations

seed:
	env $$(cat env.sh) ruby seeds.rb

secret:
	ruby -r securerandom -e 'puts SecureRandom.hex(32)'

server:
	env $$(cat env.sh) shotgun -o 0.0.0.0

test:
	env $$(cat env.sh) cutest test/**/*_test.rb
