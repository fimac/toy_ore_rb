require "toy_ore/scheme"

module ToyOre
  class OreScheme
    def initialize
      @keys = (0..255).to_a.shuffle()
      @prp = (0..255).to_a.shuffle()
    end

    def encrypt(plaintext)
      iv = rand(1..900)
      # This represents all the values in the domain.
      # e.g A domain could be all the salaries in a employee table.
      # This value is hardcoded here for the example.
      domain = (0..255).to_a

      # Array to hold the encrypted value of the cmp result for each value in the domain.
      encryptions = []

      domain.each do |d|
        # The offset is what ever index d (the plaintext) is in the shuffled PRP array.
        # If we used the plaintext value as the offset, this would give away the value of the plaintext.
        # Using the PRP, swaps the plaintext value for a random number in the PRP.
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
        binding.pry
        encryptions[offset] = ToyOre::Scheme.encrypt(iv, @keys[offset], cmp_result)
      end

      # The left ciphertext:
      # 1.  Stores the value of the offset.
      #
      #     The offset is the index of the encrypted comparison result,
      #     in the encryptions array.
      #
      # 2.  Stores the key that was used to encrypt the comparison result.
      #
      # The right ciphertext:
      #
      # 1.  Stores the IV used in the encryption
      # 2.  Stores an array of all encrypted comparison results.
      #
      {
        left: {
          offset: @prp[plaintext],
          key: @keys[@prp[plaintext]]
        },
        right: {
          iv: iv,
          encryptions: encryptions
        }
      }
    end
  end
end
