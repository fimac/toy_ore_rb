# Toy ORE library

A toy ORE library, built for education purposes.

It was built to get an understanding of Order Revealing Encryption works.

This is an unsafe implementation, only to be used for educational purposes.

DO NOT USE IN PRODUCTION.

## Installation

Add this line to your application’s Gemfile:

```ruby
gem "toy-ore"
```

Run:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install toy-ore
```

## Usage

1. Initialize an ore client:

The default domain size is 1 byte.

```ruby
ore_client = ToyOre::Scheme::OreScheme.new()
```

2. Encrypt:

```ruby
ct_one = ore_client.encrypt(3)
ct_two = ore_client.encrypt(8)
```

3. Compare:


```ruby
irb(main):004:0> ct_one.left.<=>(ct_two.right)

=> -1
```

