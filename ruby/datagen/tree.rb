
# generate a non-weighted tree
def tree_weightless(nodes, random: nil)
  random ||= Random.new
  nodes = nodes.shuffle(random: random)
  edges = []
  placed = [nodes[0]]
  nodes[1..-1].each{ |t|
    f = placed.sample
    edges << [f,t]
    placed << t
  }
  edges
end

# generate a tree weighted by integers
def tree_weighted_int(nodes, wait_range, random: nil)
  random ||= Random.new
  nodes = nodes.shuffle(random: random)
  edges = []
  placed = [nodes[0]]
  nodes[1..-1].each{ |t|
    f = placed.sample
    edges << [f,t,random.rand(wait_range)]
    placed << t
  }
  edges
end

# TESTCODE
arr = ("a".."f").to_a
puts arr.size
tree_weighted_int(arr, 1..100, random: Random.new(1)).each{ |line| puts line.join(" ") }