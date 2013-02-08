#!/usr/bin/env ruby
require 'rubygems'
require 'json'
require 'httparty'
require 'uri'

class ContentsNavi
  class Error < StandardError
  end

  attr_accessor :username, :password
  attr_reader :base_url

  def initialize
    @base_url = 'https://trial-test.cloudlabs.sharp.co.jp/contents_navi/stable'
    if block_given?
      yield self
    end
  end

  def relations_url(item_id, params={:cat => :crossitem})
    params[:id] = item_id
    request_opts = params.map{|k,v|
      "#{k}=#{URI.escape v.to_s}"
    }.join('&')
    "#{@base_url}/relations?#{request_opts}"
  end

  def relations(item_id, params={:cat => :crossitem})
    params[:id] = item_id
    request_opts = params.map{|k,v|
      "#{k}=#{URI.escape v.to_s}"
    }.join('&')
    url = "#{@base_url}/home/similar_books?#{request_opts}"
    res = HTTParty.get url, :basic_auth => {:username => @username, :password => @password}
    JSON.parse(res.body).map{|i|
      id, title, img, unknown, unknown, category, url = i
      {
        :id => id,
        :title => title,
        :img => img,
        :category => category,
        :url => url
      }        
    }
  end
end

if __FILE__ == $0
  require File.expand_path '../bootstrap', File.dirname(__FILE__)
  require 'pp'

  navi = ContentsNavi.new do |conf|
    conf.username = Conf['CONTENTS_NAVI_USER']
    conf.password = Conf['CONTENTS_NAVI_PASS']
  end
  pp navi.relations 1000
  puts navi.relations_url 1000
end
