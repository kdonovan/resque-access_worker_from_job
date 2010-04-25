# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{resque-access_worker_from_job}
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kali Donovan"]
  s.date = %q{2010-04-25}
  s.description = %q{By allowing multiple jobs to share a single socket, which is persisted over the life of the worker, this plugin is an important building block for implementing a Resque-based service send background iPhone messages via the Apple Push Notification servers.}
  s.email = %q{kali.donovan@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "init.rb",
     "lib/resque-access_worker_from_job.rb",
     "lib/resque/plugins/access_worker_from_job.rb",
     "rails/init.rb",
     "resque-access_worker_from_job.gemspec"
  ]
  s.homepage = %q{http://github.com/kdonovan/resque-access_worker_from_job}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Resque plugin to allow jobs access to their calling worker at runtime.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<resque>, [">= 0"])
    else
      s.add_dependency(%q<resque>, [">= 0"])
    end
  else
    s.add_dependency(%q<resque>, [">= 0"])
  end
end

