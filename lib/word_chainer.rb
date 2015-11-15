require "set"

class WordChainer
  DICTIONARY = Set.new(File.read("wordlist.txt").chomp.split("\n"))

  def initialize(initial, target)
    @initial = initial
    @target = target
  end

  def build_list
    list = [@initial]
    words_with_length = DICTIONARY.select { |w| w.length == @initial.length }

    until list.last == @target || list.size == 100
      next_word = next_close_word(list.last)
      if next_word
        list.push(next_word)
        next
      end

      possibilities = words_with_length.select { |w| different_letters(w, list.last).size == 1 }
      list.push(possibilities.sample)
    end
    list
  end

  def next_close_word(current)
    current.length.times do |index|
      next_word = current.dup
      next_word[index] = @target[index]
      return next_word if next_word != current && DICTIONARY.include?(next_word)
    end
    nil
  end

  def different_letters(word1, word2)
    word1.chars.select.with_index { |char, i| char != word2[i] }
  end
end
