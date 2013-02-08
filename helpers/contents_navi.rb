helpers do

  def contents_navi
    @@contents_navi ||= ContentsNavi.new do |conf|
      conf.username = Conf['CONTENTS_NAVI_USER']
      conf.password = Conf['CONTENTS_NAVI_PASS']
    end
  end

  def contents_navi_relations(item_id)
    key = URI.encode "cnavi_relations_#{item_id}"
    begin
      return JSON.parse( Cache.get(key) || Cache.set(key, contents_navi.relations(item_id).to_json, 60*5) )
    rescue StandardError, Timeout::Error => e
      throw :halt, [500, 'Internal Server Error']
    end
  end

  def contents_navi_relations_url(item_id)
    contents_navi.relations_url item_id
  end

end
