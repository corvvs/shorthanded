
def permutation(from, to, random: nil)
  (from..to).to_a.shuffle(random: random)
end

p permutation(2, 24, random: Random.new(1))