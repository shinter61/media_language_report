require 'active_support/all'
require 'csv'

f = File.open('./corpas.txt')
corpas = f.read
f.close

split_chars = corpas.split(//)

split_chars.select! { |char| char.present? }

ranking = split_chars.group_by { |i| i }.map { |k, v| { k => v.size } }
ranking.sort_by! { |hash| hash.values.first }.reverse!

CSV.open('kadai1.csv', 'w', col_sep: ' ') do |csv|
  ranking.each.with_index(1) do |hash, index|
    csv << [index, hash.values.first]
  end
end
