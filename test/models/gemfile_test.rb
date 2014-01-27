require_relative "../helper"

test "scans gems from gemfile" do
  gemfile = <<-GEMFILE
source "https://rubygems.org"

ruby "2.0.0"

gem 'pg', "1.0.0"
gem "puma", '2.0.0'
gem 'coffee-rails'
GEMFILE

  assert_equal %w(pg puma coffee-rails), Gemfile.new(gemfile).gems
end

test "ignores commented gems" do
  gemfile = <<-GEMFILE
# gem "rails"
#gem "puma"
GEMFILE

  gems = Gemfile.new(gemfile).gems

  assert gems.empty?
end

test "ignores rails gem" do
  gemfile = <<-GEMFILE
gem "rails"
GEMFILE

  gems = Gemfile.new(gemfile).gems

  assert gems.empty?
end
