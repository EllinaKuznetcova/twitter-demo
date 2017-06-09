require 'rake'
require 'hanami/rake_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs    << 'spec'
  t.warning = false
end

task :environment do
  require_relative './config/environment'
  # Hanami::Application.preload!
end

task default: :test
task spec: :test

task fetch_tweets: :environment do
  FetchTweets.new.perform
end
