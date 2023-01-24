module ToyOre
  module Scheme
    # Encrypts a comparison result by XOR'ing the iv and key. Then XORing that result with the comparaison result.
    #
    # Uses an IV for non-determinism.
    #
    # A Boolean logic operation that compares two input bits and generates one output bit.
    # If the bits are the same, the result is 0. If the bits are different, the result is 1.
    # ^ represents the xor operator
    #
    # @param iv [Integer]
    #
    # @param key [Integer]
    #
    # @param cmp_result [Integer] -1, 0, 1
    #
    # @return [Integer]
    def self.encrypt(iv, key, cmp_result)
      (iv ^ key) ^ cmp_result
    end

    # Compares 2 plaintexts and returns a cmp_result.
    # If a < b -1
    # If a == b 0
    # if a > b 1
    #
    # @param a [Integer] A plaintext integer value
    #
    # @param b [Integer] A plaintext integer value
    #
    # @return cmp_result [Integer] The comparison result
    def self.compare_plaintexts(a, b)
      if a < b
        return -1
      elsif a == b
        return 0
      else
        return 1
    end
  end
end
end
