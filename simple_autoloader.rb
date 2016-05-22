# this is simple autoloader for this small application

# require gems
require 'uri'
require 'net/http'
require 'json'
require 'faye/websocket'
require 'eventmachine'

# add current path to $LOAD_PATH
$: << File.join(File.dirname(__FILE__))

# load all lib files
Dir[File.join('lib', '**', '*.rb')].each {|file| require file }