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
    # If a < b = -1
    # If a == b = 0
    # if a > b = 1
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
    # created by the same ore client. egToyOre::Scheme::OreScheme.new()
    #
    # @param left_ciphertext [Object]
    #
    # @param right_ciphertext [Object]
    #
    #
    # @ return [Integer] The comparison result
    #
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
      (right_ciphertext.iv ^ left_ciphertext.key) ^ right_ciphertext.encryptions[left_ciphertext.offset]
    end

    class LeftCiphertext
      attr_reader :offset, :key

      def initialize(offset, key)
        @offset = offset
        @key = key
      end

      def <=>(right_ciphertext)
        ToyOre::Scheme.compare_ciphertexts(self, right_ciphertext)
      end
    end

    class RightCiphertext
      attr_reader :iv, :encryptions

      def initialize(iv, encryptions)
        @iv = iv
        @encryptions = encryptions
      end

      def <=>(left_ciphertext)
        ToyOre::Scheme.compare_ciphertexts(left_ciphertext, self)
      end
    end

    class OreCiphertext
      attr_reader :left, :right

      def initialize(offset, key, iv, encryptions)
        @left = LeftCiphertext.new(offset, key)
        @right = RightCiphertext.new(iv, encryptions)
      end
    end

    class OreScheme
      def initialize(domain_size = 0..255)
        @domain_size = domain_size

        # PRF key - hash key
        @prf = (domain_size).to_a.shuffle()
        # PRP key - shuffle key
        @prp = (domain_size).to_a.shuffle()
      end

      def encrypt(plaintext)
        iv = rand(@domain_size)

        # This represents all the values in the domain.
        # This is a small domain example.
        # This is 1 block, 1 byte, 8 bits, total value is 256.
        domain = (@domain_size).to_a

        # Array to hold the encrypted value of the cmp result for each value in the domain.
        encryptions = []

        domain.each do |d|
          # The offset is what ever index d (domain value) is in the shuffled PRP array.
          # If we used the plaintext value as the offset, this would give away the value of the plaintext.
          # Using the PRP, swaps the plaintext value for a random number in the PRP to store the encrypted
          # comparison result in the right ciphertext encryptions array.
          offset = @prp[d]

          # Compare the domain value to the plaintext value
          # We get -1, 0 or 1 here.
          cmp_result = ToyOre::Scheme.compare_plaintexts(d, plaintext)

          # At index offset in the encryptions array
          # set the xor'd value of (iv and value) xor'd with the cmp result
          # to the index at the offset value.

          # We store the encrypted value of the comparison result
          # in the encryptions array
          # at the index = to the offset.
          #
          # To encrypt we pass the random iv, the key is the value at the offset index in the
          # random shuffled key array.
          #
          #
          encryptions[offset] = ToyOre::Scheme.encrypt(iv, @prf[offset], cmp_result)
        end

        # The left ciphertext:
        # 1.  Stores the value of the offset.
        #
        #     The offset is the index of the encrypted comparison result,
        #     in the encryptions array.
        #
        # 2.  Stores the key that was used to encrypt the comparison result
        #     at the offset in the right ciphertext.
        #
        # The right ciphertext:
        #
        # 1.  Stores the IV used in the encryption
        # 2.  Stores an array of all encrypted comparison results.
        #
        #
        #
        OreCiphertext.new(@prp[plaintext], @prf[@prp[plaintext]], iv, encryptions)
      end
    end
  end
end

# Examples

# Initialize our tiny ORE Scheme
# ore_client = ToyOre::Scheme::OreScheme.new(0..3)

# Create ore ciphertext's for all values
# ct_a = ore_client.encrypt(0)
# ct_b = ore_client.encrypt(1)
# ct_c = ore_client.encrypt(2)
# ct_d = ore_client.encrypt(3)

# Store ct's in objects
# a = { letter: "a", ore: ct_a }
# b = { letter: "b", ore: ct_b }
# c = { letter: "c", ore: ct_c }
# d = { letter: "d", ore: ct_d }

# Compare ct's
# a[:ore].left.<=>(d[:ore].right)
# d[:ore].left.<=>(b[:ore].right)

# Create an unordered array
# unordered_array = [d, c, a, b]

# Order array using only ore ct's
# ordered_array = unordered_array.sort { |x, y| x[:ore].left.<=>(y[:ore].right) }.map { |a| a[:letter] }
