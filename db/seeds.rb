require 'pry'
require 'csv'
["data"].each do |file|
  tables = CSV.read("db/#{file}.csv", headers: true)
  tables.each do |table|
    if table["英語"]
      conv_category = case table["カテゴリ"]
                 when 'A' then 0
                 when 'B' then 1
                 when 'C' then 2
                 when 'D' then 3
                 end
      word = Word.new(
        english: table["英語"], 
        japanese: table["日本語"], 
        category: conv_category
      )
      if word.save
        puts word.english
      else
        p word.errors
        puts "えらー"
      end
    end
  end
end
