get '/con/contents_navi/:item_id' do
  @item_id = params[:item_id]
  CometIO.push :go, {:url => contents_navi_relations_url(@item_id)}
  @items = contents_navi_relations @item_id
  haml :con_contents_navi
end
