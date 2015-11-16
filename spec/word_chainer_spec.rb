require_relative "../lib/word_chainer"

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
  end
end
