require 'irb/completion'
require 'irb/ext/save-history'
require 'rubygems'
require 'pp'
require 'wirble'
require 'hirb'

IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history" 
IRB.conf[:PROMPT_MODE]  = :SIMPLE

Wirble.init
Wirble.colorize

Hirb.enable

if ENV['RAILS_ENV'] 
  load File.dirname(__FILE__) + '/.railsrc' 
end

def pb(string)
  `echo #{string}|pbcopy`
end

# print SQL to STDOUT
#if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  #require 'logger'
  #RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
#end
