require "set"
require_relative "chain_node"

class WordChainer
  DICTIONARY = Set.new(File.read("wordlist.txt").chomp.split("\n"))

  def initialize(initial, target)
    @initial_node = ChainNode.new(nil,
      word: initial,
      target: target,
      possibilities: possibilities_for_word(initial)
    )
  end

  def build_list
    @next_nodes = [@initial_node]
    @seen_words = Set.new

    process_next_node until finished?
    generate_final_list
  end

  private

  def possibilities_for_word(word)
    DICTIONARY.select { |w| w.length == word.length }
  end

  def process_next_node
    node = @next_nodes.first

    unless node.word == @initial_node.target
      @next_nodes.shift
      @seen_words.add(node.word)
      enqueue_children(node)
    end
  end

  def enqueue_children(node)
    node.children.each do |node|
      next if @seen_words.include?(node.word)
      @next_nodes.insert(index_for_node(node), node)
    end
  end

  def generate_final_list
    return if @next_nodes.empty?

    node = @next_nodes.first
    list = [node.word]
    while (node = node.parent)
      list.push(node.word)
    end
    list.reverse
  end

  def index_for_node(node)
    index = @next_nodes.find_index { |el| el.heuristic >= node.heuristic }
    index || @next_nodes.length - 1
  end

  def finished?
    @next_nodes.empty? || @next_nodes.first.word == @initial_node.target
  end
end
