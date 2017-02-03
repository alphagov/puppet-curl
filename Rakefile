require 'bundler'
Bundler.require(:rake)

require 'puppetlabs_spec_helper/rake_tasks'

PuppetLint.configuration.send("disable_80chars")

desc "Run syntax, lint, and spec tests."
task :test => [
  :syntax,
  :lint,
  :spec,
]
