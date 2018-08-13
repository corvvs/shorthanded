# connected - weightless - undirected
def graph_weightless_undirected(nodes, max_edges: nil)
  es = {}
  nodes.each{ |i| nodes.reject{ |j| j == i }.sample(rand(1..(max_edges || nodes.size))).each{ |j|
    es[[i,j].sort] = 1
  } }
  es.keys
end

# connected - weighted - undirected
def graph_weighted_undirected(nodes, max_edges: nil, weight_range: nil)
  es = {}
  nodes.each{ |i| nodes.reject{ |j| j == i }.sample(rand(1..(max_edges || nodes.size))).each{ |j|
    es[[i,j].sort] = weight_range ? rand(weight_range) : random.rand
  } }
  es.map{ |k,v| [*k, v] }
end

# connected - weightless - directed
def graph_weightless_directed(nodes, max_edges: nil)
  es = {}
  nodes.each{ |i| nodes.reject{ |j| j == i }.sample(rand(1..(max_edges || nodes.size))).each{ |j|
    es[[i,j].sort] = 1
  } }
  es.keys
end

# connected - weighted - directed
def graph_weighted_directed(nodes, max_edges: nil, weight_range: nil)
  es = {}
  nodes.each{ |i| nodes.reject{ |j| j == i }.sample(rand(1..(max_edges || nodes.size))).each{ |j|
    es[[i,j]] = weight_range ? rand(weight_range) : rand
  } }
  es.map{ |k,v| [*k, v] }
end

def graph_weighted_directed_2(nodes, random: Random.new, min_trail: 3, max_trail: 3, weight_range: nil)
  es = {}
  rand(min_trail..max_trail).times{
    f = nil
    nodes.shuffle.each { |t|
      if f
        es[[f,t]] = weight_range ? rand(weight_range) : rand
      end
      f = t
    }
  }
  es.map{ |k,v| [*k, v] }
end

S = ARGV[0]
Seed = S ? S.to_i : Random.rand(1000000007)
srand(Seed)
$stderr.puts Seed

nodes = (1..1000).to_a
#edges = graph_weighted_directed nodes, max_edges: 20, weight_range: 1..1000
edges = graph_weighted_directed_2 nodes, max_trail: 20, weight_range: 1..1000

puts [nodes.size, edges.size, 100000].join(" ")
puts nodes.map{ rand(1..1000) }.join(" ")
edges.each{ |l| puts l.join(" ") }
