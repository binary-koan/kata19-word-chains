require "set"
require_relative "chain_node"

class WordChainer
  DICTIONARY = Set.new(File.read("wordlist.txt").chomp.split("\n"))

  def initialize(initial_word, target)
    possibilities = possibilities_for_word(initial_word)
    @initial_node = ChainNode.new(nil, initial_word, possibilities)
    @target = target
  end

  def build_list
    @unseen_nodes = [@initial_node]
    @seen_words = Set.new

    process_next_node until finished?
    generate_final_list
  end

  private

  def possibilities_for_word(word)
    DICTIONARY.select { |w| w.length == word.length }
  end

  def process_next_node
    node = @unseen_nodes.first

    unless node.word == @target
      @unseen_nodes.shift
      @seen_words.add(node.word)
      enqueue_children(node)
    end
  end

  def enqueue_children(node)
    node.children.each do |node|
      next if @seen_words.include?(node.word)
      @unseen_nodes.insert(index_for_node(node), node)
    end
  end

  def generate_final_list
    return if @unseen_nodes.empty?

    node = @unseen_nodes.first
    list = [node.word]
    while (node = node.parent)
      list.push(node.word)
    end
    list.reverse
  end

  def index_for_node(node)
    index = @unseen_nodes.find_index do |el|
      el.heuristic(@target) >= node.heuristic(@target)
    end
    index || @unseen_nodes.length - 1
  end

  def finished?
    @unseen_nodes.empty? || @unseen_nodes.first.word == @target
  end
end
