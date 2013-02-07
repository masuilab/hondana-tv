
helpers do

  def books(shelf)
    key = URI.encode "books_#{shelf}"
    begin
      return JSON.parse( Cache.get(key) || Cache.set(key, Hondana.books(shelf).to_json, 60*5) )
    rescue StandardError, Timeout::Error => e
      throw :halt, [500, 'Internal Server Error']
    end
  end

end
