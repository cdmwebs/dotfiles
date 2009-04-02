require 'rubygems'
require 'wirble'
require 'pp'
require 'irb/completion'

Wirble.init
Wirble.colorize

IRB.conf[:AUTO_INDENT] = true

ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

# print SQL to STDOUT
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end
