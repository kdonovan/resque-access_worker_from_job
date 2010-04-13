require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "resque-access_worker_from_job"
    gem.summary = %Q{Resque plugin to allow jobs access to their calling worker at runtime.}
    gem.description = %Q{By allowing multiple jobs to share a single socket, which is persisted over the life of the worker, this plugin is an important building block for implementing a Resque-based service send background iPhone messages via the Apple Push Notification servers.}
    gem.email = "kali.donovan@gmail.com"
    gem.homepage = "http://github.com/kdonovan/resque-access_worker_from_job"
    gem.authors = ["Kali Donovan"]
    gem.add_dependency "resque"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "resque-access_worker_from_job #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
