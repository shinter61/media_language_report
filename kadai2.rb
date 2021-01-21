require 'csv'

# https://www.marcelwesdorp.com/uploads/2/2/6/7/22677076/gilles_deleuze___f%C3%A9lix_guattari.pdf
f = File.open('./corpas2.txt')
corpas = f.read
f.close

split_words = corpas.split(' ')
word_bigram = []
split_words.each_cons(2) do |word_pair|
  word_bigram << word_pair
end

ranking = word_bigram.group_by { |i| i }.map { |k, v| { k => v.size } }
ranking.sort_by! { |hash| hash.values.first }.reverse!

CSV.open('kadai2.csv', 'w', col_sep: ' ') do |csv|
  ranking.each.with_index(1) do |hash, index|
    csv << [index, hash.keys.first, hash.values.first]
  end
end
