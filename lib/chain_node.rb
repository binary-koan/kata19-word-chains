class ChainNode
  attr_reader :parent
  attr_reader :word
  attr_reader :target

  def initialize(parent, word:, target:, possibilities:)
    @parent = parent
    @word = word
    @target = target
    @possibilities = possibilities
  end

  def heuristic
    @word.length - distance_to_target
  end

  def children
    all_children
  end

  def inspect
    "<Node #{@word}->#{@target} from #{@parent.word}>"
  end

  private

  def all_children
    @possibilities.select do |word|
      one_letter_different?(word, @word)
    end.map do |word|
      ChainNode.new(self, word: word, target: @target, possibilities: @possibilities)
    end
  end

  def one_letter_different?(word1, word2)
    word1.chars.select.with_index { |char, i| char != word2[i] }.size == 1
  end

  def distance_to_target
    @word.chars.select.with_index do |char, i|
      @target[i] == char
    end.size
  end
end
