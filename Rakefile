# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

begin
  require 'hydra'
  require 'hydra/tasks'
  Hydra::TestTask.new('hydra:spec') do |t|  
    t.add_files 'spec/**/*_spec.rb'
  end
rescue MissingSourceFile
end
