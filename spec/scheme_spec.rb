require "toy_ore/scheme"
require "toy_ore/ore_scheme"


RSpec.describe ToyOre::Scheme do
  describe "compare_plaintexts" do
    it "returns -1 if a < b" do
      result = ToyOre::Scheme.compare_plaintexts(10, 20)
      expect(result).to eq(-1)
    end

    it "returns 0 if a == b" do
      result = ToyOre::Scheme.compare_plaintexts(10, 10)
      expect(result).to eq(0)
    end

    it "returns 1 if a > b" do
      result = ToyOre::Scheme.compare_plaintexts(30, 20)
      expect(result).to eq(1)
    end
  end
end

RSpec.describe ToyOre::Scheme::OreScheme do
end
