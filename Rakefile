require 'rake/testtask'
require 'yard'
require 'rubygems/tasks'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

YARD::Rake::YardocTask.new

desc "Run all tasks"
task :default do
  Rake::Task[:test].execute
  Rake::Task[:yard].execute
end

Gem::Tasks.new
