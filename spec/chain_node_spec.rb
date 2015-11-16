require "spec_helper"

describe ChainNode do
  let(:word) { "heap" }
  let(:target) { "hope" }
  let(:possibilities) { [] }

  subject(:node) do
    ChainNode.new(nil, word, possibilities)
  end

  describe "#heuristic" do
    subject { node.heuristic(target) }

    context "when the word and target are equal" do
      let(:word) { "heap" }
      let(:target) { "heap" }

      it { is_expected.to be_zero }
    end

    context "with a one character difference" do
      let(:word) { "cut" }
      let(:target) { "cat" }

      it { is_expected.to eq 1 }
    end

    context "with the same letters in different positions" do
      let(:word) { "ate" }
      let(:target) { "eat" }

      it { is_expected.to eq word.length }
    end

    context "with completely different letters" do
      let(:word) { "haste" }
      let(:target) { "grunt" }

      it { is_expected.to eq word.length }
    end
  end

  describe "#children" do
    let(:possibilities) { ["herp", "weap", "help", "soap", "rain"] }

    subject(:children) { node.children }

    it "includes possibilities which are one letter different" do
      expect(children[0].word).to eq "herp"
      expect(children[1].word).to eq "weap"
      expect(children[2].word).to eq "help"
    end

    it "does not include words outside possibilities" do
      expect(children.size).to eq 3
    end

    it "does not include possibilities which are not one letter different" do
      expect(children).not_to include "soap"
      expect(children).not_to include "rain"
    end
  end
end
