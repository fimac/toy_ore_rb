require "toy_ore/scheme"

module ToyOre
  class OreScheme
    def initialize
      @keys = (1..255).to_a.shuffle()
      @prp = (1..255).to_a.shuffle()
    end

    def encrypt(plaintext)
      iv = rand(0..900)
      # This represents all the values in the domain.
      # e.g A domain could be all the salaries in a employee table.
      domain = (1..255).to_a

      # Array to hold the encrypted value of the cmp result for each value in the domain.
      encryptions = []

      domain.each do |d|
        # Our offset is the value at index domain in the suffled array of integers.
        offset = @prp[d]

        # Compare the domain value to the plaintext value
        cmp_result = ToyOre::Scheme.compare_plaintexts(d, plaintext)

        # At index offset in the encrytions array
        # set the xor'd value of (iv and value) xor'd with the cmp result
        # to the index at the offset value.
        encryptions[offset] = ToyOre::Scheme.encrypt(iv, @keys[offset], cmp_result)
      end

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
