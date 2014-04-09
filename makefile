.PHONY: test

console:
		env $$(cat env.sh) pry -r ./app.rb

seed:
		env $$(cat env.sh) ruby seeds.rb

secret:
	ruby -r securerandom -e 'puts SecureRandom.hex(32)'

server:
		env $$(cat env.sh) shotgun -o 0.0.0.0

test:
		env $$(cat env.sh) cutest test/**/*_test.rb
