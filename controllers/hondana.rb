get '/con/:shelf' do
  @shelf = params[:shelf]
  CometIO.push :go, {:url => "http://hondana.org/#{@shelf}"}
  @books = Hondana.books @shelf
  haml :con_hondana
end
