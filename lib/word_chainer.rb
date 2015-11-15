require "set"

class WordChainer
  DICTIONARY = File.read("wordlist.txt").chomp.split("\n")

  def initialize(initial, target)
    @initial = initial
    @target = target
  end

  def build_list
    list = [@initial]
    used = Set.new

    until list.last == @target || list.size == 100
      possibilities = words_similar_to(list.last)

      new_word = nil
      possibilities.each do |possibility|
        if !used.include?(possibility) && closer_to_target?(list.last, possibility)
          new_word = possibility
          break
        end
      end

      if used.include?(new_word)
        list.pop
      else
        list.push(new_word || possibilities.sample)
        used.add(list.last)
      end
    end
    list
  end

  def words_similar_to(word)
    words_with_length = DICTIONARY.select { |w|
      w.length == word.length
    }
    words_with_length.select { |w| different_letters(w, word) == 1 }
  end

  def different_letters(word1, word2)
    # BAD
    w2chars = word2.chars
    differences = 0
    word1.chars.each.with_index do |char, i|
      differences += 1 if char != w2chars[i]
    end
    differences
  end

  def closer_to_target?(current, possibility)
    different_letters(@target, possibility) < different_letters(@target, current)
  end
end
