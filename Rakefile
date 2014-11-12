require "bundler/gem_tasks"

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ["-Ijar", "-Ilib", "-c", "-f progress"] # '--format specdoc'
  t.pattern = 'spec/**/*_spec.rb'
end

task :compile do
  require 'rubygems'

  jarname = FileList['norikra-udf-*.gemspec'].first.gsub(/\.gemspec$/, '.jar')

  jarfiles = FileList['jar/**/*.jar'].select{|f| not f.end_with?('/' + jarname)}
  jarfiles << Gem.find_latest_files('esper-*.jar').first

  java_classpath = "-classpath src:java:#{jarfiles.join(':')}"
  FileList['src/**/*.java'].each do |fn|
    sh "env LC_ALL=C javac -J-Duser.language=en #{java_classpath} -d java #{fn}"
  end

  jruby_classpath = "--classpath java:#{jarfiles.join(':')}"
  FileList['lib/esper_plugin/**/*.rb'].each do |fn|
    sh "env LC_ALL=C jrubyc --javac --target java #{jruby_classpath} #{fn}"
  end

  sh "env LC_ALL=C jar -J-Duser.language=en -cf jar/#{jarname} -C java ."
end

task :clean do
  sh "rm -rf java/*"
end

task :test => [:compile, :spec]
task :default => :test

task :all => [:clean, :compile, :spec, :build]
