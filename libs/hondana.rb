#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'nokogiri'
require 'tmp_cache'
require 'http'
require 'uri'

class Hondana
  def self.base_url
    'http://hondana.org'
  end

  def self.books(shelf)
    url = "#{base_url}/#{shelf}"
    doc = Nokogiri::HTML Http.get(URI.encode url)
    doc.xpath('//a').select{|a|
      a['href'] =~ /^\/#{URI.encode shelf}\/[A-Z0-9]{10}/
    }.map{|a|
      asin = a['href'].gsub(/^\/#{URI.encode shelf}\//, '')
      {
        :url => "#{base_url}/#{shelf}/#{asin}",
        :title => (a.child.attributes['alt'].value rescue nil),
        :img_s => (a.child.attributes['src'].value rescue nil),
        :img => "http://images-jp.amazon.com/images/P/#{asin}.jpg"
      }
    }.reject{|i|
      i[:img_s] == nil
    }
  end
end

if __FILE__ == $0
  require 'pp'
  pp  Hondana.books('増井')
end
