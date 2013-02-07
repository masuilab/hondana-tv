require 'rubygems'
require 'bundler/setup'
Bundler.require
require 'sinatra/cometio'
if development?
  $stdout.sync = true
  require 'sinatra/reloader'
end

require File.expand_path 'bootstrap', File.dirname(__FILE__)
Bootstrap.init :inits, :libs, :helpers, :controllers

set :haml, :escape_html => true

run Sinatra::Application
