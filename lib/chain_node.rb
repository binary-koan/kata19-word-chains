class ChainNode
  attr_reader :parent
  attr_reader :word
  attr_reader :possible_children

  def initialize(parent, word, possible_children)
    @parent = parent
    @word = word
    @possible_children = possible_children
  end

  def heuristic(target)
    different_chars(@word, target)
  end

  def children
    child_words = possible_children.select { |other| one_letter_different?(word, other) }
    child_words.map { |word| ChainNode.new(self, word, possible_children) }
  end

  def inspect
    "<Node #{word} from #{parent.word}>"
  end

  private

  def one_letter_different?(first_word, second_word)
    different_chars(first_word, second_word) == 1
  end

  def different_chars(first_word, second_word)
    combination = first_word.chars.zip(second_word.chars)
    combination.count { |first_char, second_char| first_char != second_char }
  end
end
