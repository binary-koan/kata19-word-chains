require "set"

class WordChainer
  DICTIONARY = Set.new(File.read("wordlist.txt").chomp.split("\n"))

  def initialize(initial, target)
    fail("Initial and target word must be the same length") unless initial.length == target.length

    @initial = initial
    @target = target
    @possibilities = words_with_length(initial.length)
  end

  def build_list
    list = [@initial]
    list << next_word(list.last) until complete?(list)
    list
  end

  private

  def words_with_length(length)
    DICTIONARY.select { |word| word.length == length }
  end

  def next_word(current)
    next_close_word(current) || possible_next_words(current).sample
  end

  def next_close_word(current)
    close_words(current).detect do |word|
      word != current && DICTIONARY.include?(word)
    end
  end

  def close_words(current)
    current.length.times.map do |index|
      word = current.dup
      word[index] = @target[index]
      word
    end
  end

  def possible_next_words(current)
    @possibilities.select { |w| one_letter_different?(w, current) }
  end

  def one_letter_different?(word1, word2)
    word1.chars.select.with_index { |char, i| char != word2[i] }.size == 1
  end

  def complete?(list)
    list.last == @target || list.size == 100
  end
end
