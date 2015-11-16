require "spec_helper"

describe WordChainer do
  let(:initial) { nil }
  let(:target) { nil }
  let(:word_chainer) { WordChainer.new(initial, target) }

  describe "#build_list" do
    subject(:list) { word_chainer.build_list }

    context "when the target can be discovered immediately" do
      let(:initial) { "cat" }
      let(:target) { "rat" }

      it "finds a two-element solution" do
        expect(list.size).to eq 2
      end

      it "starts with the initial word" do
        expect(list.first).to eq initial
      end

      it "ends with the target word" do
        expect(list.last).to eq target
      end
    end

    context "when the target can be discovered in two steps" do
      let(:initial) { "bat" }
      let(:target) { "cut" }

      it "finds a three-element solution" do
        expect(list.size).to eq 3
      end

      it "passes through one of the two possible options" do
        expect(list[1]).to match(/but|cat/)
      end
    end

    context "when the target cannot easily be discovered" do
      let(:initial) { "house" }
      let(:target) { "shout" }

      it "finds a solution" do
        expect(list).not_to be_nil
      end
    end
  end
end
