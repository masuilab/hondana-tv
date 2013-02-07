get '/con/:shelf' do
  @shelf = params[:shelf]
  CometIO.push :go, {:url => "http://hondana.org/#{@shelf}"}
  @shelf
end
