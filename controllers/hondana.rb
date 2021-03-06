# -*- coding: utf-8 -*-
get '/con/:shelf' do
  @shelf = params[:shelf]
  @title = "#{@shelf}の本棚"
  CometIO.push :go, {:url => "http://hondana.org/#{@shelf}"}
  @books = books @shelf
  haml :con_hondana
end

get '/con/similar_books/:keyword' do
  @keyword = params[:keyword]
  @title = "「#{@keyword}」の関連本"
  @books = similar_books @keyword
  CometIO.push :go, {:url => "#{app_root}/tv/similar_books/#{@keyword}"}
  haml :con_hondana
end

get '/tv/similar_books/:keyword' do
  @keyword = params[:keyword]
  @title = "「#{@keyword}」の関連本"
  @books = similar_books @keyword
  haml :tv_hondana
end
