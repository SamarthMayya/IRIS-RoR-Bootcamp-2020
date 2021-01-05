# The function `lower_case` takes an array of strings and converts
# any non-lower case alphabet (A..Z) to corresponding lower case
# alphabet
def lower_case(words)
  nam = Array.new
  words.each do |word|
    nam.push(word.downcase)
  end 
  return nam
end

# Similar to `lower_case`, this function modifies the array in-place
# and does not return any value.
def lower_case!(words)
  words.each do |word|
    word.downcase!
  end 
end

# Given a prefix and an array of words, return an array containing
# words that have same prefix.
#
# For example:
# words_with_prefix('apple', ['apple', 'ball', 'applesauce']) would
# return the words 'apple' and 'applesauce'.
def words_with_prefix(prefix, words)
  nam = Array.new
  words.each do |word|
    if(word.start_with?(prefix))
      nam.push(word) 
    end 
  end 
  return nam 
end

# The similarity score between two words is defined as the length of
# largest common prefix between the words.
#
# For example:
# - Similarity of (bike, bite) is 2 as 'bi' is the largest common prefix.
# - Similarity of (apple, bite) is 0 as there are no common letters in
#   the prefix
# - similarity of (applesauce, apple) is 5 as 'apple' is the largest
#   common prefix.
# 
# The function `similarity_score` takes two words and returns the
# similarity score (an integer).
def similarity_score(word_1, word_2)
  i=0
  while word_1[i] == word_2[i]
    i = i+1
  end 
  return i 
end

# Given a chosen word and an array of words, return an array of word(s)
# with the maximum similarity score in the order they appear.
def most_similar_words(chosen_word, words)
  c=0
  ssc = Array.new
  words.each do |word|
    x = similarity_score(chosen_word, word)
    c = [c,x].max
    ssc.push(x)
  end 
  nam = Array.new
  for i in 0...words.size
    if c == ssc[i]
      nam.push(words[i])
    end 
  end 
  return nam  
end
