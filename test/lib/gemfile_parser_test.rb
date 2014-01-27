require_relative "../../lib/gemfile_parser"

test "scans gems from gemfile" do
  gemfile = <<-GEMFILE
source "https://rubygems.org"

ruby "2.0.0"

gem "rails", "4.0.0"
gem 'pg', "1.0.0"
gem "puma", '2.0.0'
gem 'coffee-rails'
GEMFILE

  expected = %w(rails pg puma coffee-rails)

  assert_equal expected, GemfileParser.new(gemfile).gems
end

test "ignores commented gems" do
  gemfile = <<-GEMFILE
source "https://rubygems.org"

ruby "2.0.0"

# gem "rails"
#gem "puma"
GEMFILE

  gems = GemfileParser.new(gemfile).gems

  assert gems.empty?
end
