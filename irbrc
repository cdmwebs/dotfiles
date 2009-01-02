require 'rubygems'
require 'wirble'
require 'pp'
require 'irb/completion'

Wirble.init
Wirble.colorize

IRB.conf[:AUTO_INDENT] = true

ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
