require 'rubygems' rescue nil
require 'irb/completion'
require 'irb/ext/save-history'
begin
  require 'pp'
rescue LoadError => err
  warn "Couldn't load pretty print: #{err}"
end

begin
  require 'wirble'
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load wirble: #{err}"
end

begin
  require 'hirb'
  #Hirb.enable
rescue LoadError => err
  warn "Couldn't load hirb: #{err}"
end

IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history" 
IRB.conf[:PROMPT_MODE]  = :SIMPLE

if ENV['RAILS_ENV'] && File.exists?(File.dirname(__FILE__) + '/.railsrc')
  load File.dirname(__FILE__) + '/.railsrc' 
end

# Log to STDOUT if in Rails
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  #RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
  #IRB.conf[:USE_READLINE] = true

  # Display the RAILS ENV in the prompt
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

def sql_on
  #RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

def routing_tools(host = 'example.com')
  self.include ActionController::UrlWriter
  default_url_options[:host] = host
  ActionController::Routing::Routes
end
