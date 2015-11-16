class ChainNode
  attr_reader :parent
  attr_reader :word

  def initialize(parent, word, possibilities)
    @parent = parent
    @word = word
    @possibilities = possibilities
  end

  def heuristic(target)
    @word.length - difference_to(target)
  end

  def children
    to_children(@possibilities.select { |word| one_letter_different?(word, @word) })
  end

  def inspect
    "<Node #{@word}->#{@target} from #{@parent.word}>"
  end

  private

  def to_children(words)
    words.map do |word|
      ChainNode.new(self, word, @possibilities)
    end
  end

  def one_letter_different?(word1, word2)
    word1.chars.select.with_index { |char, i| char != word2[i] }.size == 1
  end

  def difference_to(target)
    @word.chars.select.with_index do |char, i|
      target[i] == char
    end.size
  end
end
