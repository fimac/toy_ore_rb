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

RSpec.describe ToyOre::OreScheme do
  describe "comparing encrypted values" do
    it "left ciphertexts are deterministic" do
      ore = ToyOre::OreScheme.new()
      ct_one = ore.encrypt(42)

      ct_two = ore.encrypt(42)

      expect(ct_one[:left][:key]).to eq(ct_two[:left][:key])
    end

    it "right ciphertexts are non deterministic" do
      ore = ToyOre::OreScheme.new()

      ct_one = ore.encrypt(42)
      ct_two = ore.encrypt(42)

      expect(ct_one[:right][:encryptions]).not_to eq(ct_two[:right][:encryptions])
    end
  end
end
