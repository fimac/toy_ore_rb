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
      binding.pry
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

    # Compares the left part of a ciphertext with the right part of a ciphertext,
    # created by the same ore client. eg ToyOre::OreScheme.new()
    #
    # @param left_ciphertext [Object]
    #
    # @param right_ciphertext [Object]
    #
    #
    # @ return [Integer] The comparison result
    # -1 if the left ciphertext is less than the right ciphertext
    #
    # 0 if the left ciphertext is equal to the right ciphertext
    #
    # 1 if the left ciphertext is greater than the right ciphertext
    #
    # To get the comparison result:
    # We need the iv from the right ciphertext.
    # The key from the left ciphertext.
    # The value at the index of the offset from the left ciphertext, in the right ciphertext's encryption array.
    # When we Xor the iv and key, with the encrypted value we get the comparison result

    # eg
    # [1] pry(ToyOre::Scheme)> iv
    # => 416
    # [2] pry(ToyOre::Scheme)> key
    # => 208
    # [3] pry(ToyOre::Scheme)> iv ^ key
    # => 368
    # [4] pry(ToyOre::Scheme)> (iv ^ key) ^ cmp_result
    # => -369
    # [5] pry(ToyOre::Scheme)> (iv ^ key) ^ -369
    # => -1
    def self.compare_ciphertexts(left_ciphertext, right_ciphertext)
      (right_ciphertext[:iv] ^ left_ciphertext[:key]) ^ right_ciphertext[:encryptions][left_ciphertext[:offset]]
      binding.pry
    end
  end
end
