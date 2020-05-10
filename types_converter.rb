require 'nokogiri'
require 'json'

res = {}
doc = File.open('./mpmissions/dayzOffline.chernarusplus/db/types.xml') { |f| Nokogiri::XML(f) }
doc.xpath('//type').each do |t|
  category_name = t.xpath('category/@name').to_s
  if res.key?(category_name)
    res[category_name] << t.xpath('@name').to_s
  else
    res[category_name] = [t.xpath('@name').to_s]
  end
end

File.open('./types_pretty.json', 'w') do |f|
  f.write JSON.pretty_generate(res)
end
