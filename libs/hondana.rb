#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'nokogiri'
require 'http'
require 'uri'
require 'open-uri'
require 'json'

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

  def self.enzan(cmd)
    JSON.parse open("#{base_url}/enzan/calculate/?cmd=#{cmd}").read rescue []
  end

  def self.similar_books(keyword, count=50)
    enzan("%22#{URI.encode keyword}%22.books.similarbooks(#{count})").map{|i|
      {
        :url => "#{base_url}/#{i['shelves'].sample}/#{i['isbn']}",
        :title => i['title'],
        :img_s => "http://images-jp.amazon.com/images/P/#{i['isbn']}.01.jpg",
        :img => "http://images-jp.amazon.com/images/P/#{i['isbn']}.jpg"
      }
    }
  end
end

if __FILE__ == $0
  require 'pp'
  # pp  Hondana.books('増井')
  pp Hondana.similar_books('ハイスコアガール', 5)
end
