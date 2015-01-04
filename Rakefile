require 'rake/testtask'
require 'yard'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

YARD::Rake::YardocTask.new

desc "Run all tasks"
task :default do
  Rake::Task[:test].execute
  Rake::Task[:yard].execute
end
