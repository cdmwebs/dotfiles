require 'irb/completion'
require 'irb/ext/save-history'
require 'rubygems'
require 'pp'
require 'wirble'
require 'hirb'

IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history" 
IRB.conf[:PROMPT_MODE]  = :SIMPLE

Wirble.init
Wirble.colorize

Hirb.enable

if ENV['RAILS_ENV'] && File.exists?(File.dirname(__FILE__) + '/.railsrc')
  load File.dirname(__FILE__) + '/.railsrc' 
end

# Log to STDOUT if in Rails
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
  #IRB.conf[:USE_READLINE] = true

  # Display the RAILS ENV in the prompt
  # ie : [Development]>> 
  IRB.conf[:PROMPT][:CUSTOM] = {
   :PROMPT_N => "#{ENV["RAILS_ENV"]} >> ",
   :PROMPT_I => "#{ENV["RAILS_ENV"]} >> ",
   :PROMPT_S => nil,
   :PROMPT_C => "?> ",
   :RETURN => "=> %s\n"
   }
  # Set default prompt
  IRB.conf[:PROMPT_MODE] = :CUSTOM
end

# We can also define convenient methods (credits go to thoughtbot)
def me
  User.find_by_email("cdmwebs@gmail.com")
end

def pb(string)
  `echo #{string}|pbcopy`
end

# Simple timer for benchmarks
# http://github.com/jimweirich/irb-setup/blob/master/timer.rb
def tm()
  start = Time.now
  result = yield
  delta = Time.now - start
  puts "Elapsed: #{delta} seconds"
  result
end
