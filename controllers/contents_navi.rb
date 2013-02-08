# -*- coding: utf-8 -*-
get '/con/contents_navi/:item_id' do
  @item_id = params[:item_id]
  navi = ContentsNavi.new do |conf|
    conf.username = Conf['CONTENTS_NAVI_USER']
    conf.password = Conf['CONTENTS_NAVI_PASS']
  end
  
  CometIO.push :go, {:url => navi.relations_url(@item_id)}
  @items = navi.relations @item_id
  haml :con_contents_navi
end
