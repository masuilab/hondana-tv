
helpers do

  def books(shelf)
    key = URI.encode "books_#{shelf}"
    begin
      return JSON.parse( Cache.get(key) || Cache.set(key, Hondana.books(shelf).to_json, 60*5) )
    rescue StandardError, Timeout::Error => e
      throw :halt, [500, 'Internal Server Error']
    end
  end

  def similar_books(search_word)
    key = URI.encode "similar_books_#{search_word}"
    begin
      JSON.parse( Cache.get(key) || Cache.set(key, Hondana.similar_books(search_word).to_json, 60*60*5) )
    rescue StandardError, Timeout::Error => e
      throw :halt, [500, 'Internal Server Error']
    end
  end

end
