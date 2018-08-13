require_relative '../container/updatable_heap'
require 'benchmark'

def shortest_dfs(nodes, edges, start, infinity: 1 << 32)
  def r(current, edges, weight, visited = {})
    visited[current] = weight
    (edges[current] || {}).each{ |to,w|
      nw = w + weight
      next if visited[to] < nw
      r(to, edges, nw, visited)
    }
    visited
  end
  vs = Hash[nodes.map{ |n| [n,infinity] }]
  r(start, edges, 0, vs).map{ |node,d| { id:node, d:d } } 
end

def shortest_dijkstra(nodes, edges, start, infinity: 1 << 32)
  ns = Updatable_Binary_Heap.new(list: nodes.map{ |n| { id: n, d: n == start ? 0 : infinity } }) { |s,t| s[:d] <= t[:d] }
  vs = Hash[ns.a.map{ |v| [v[:v][:id], v]}]
  #p ns
  #p vs
  determined = {}
  cnt = 0
  while ui = ns.shift
    u = ui[:v]
    cnt += 1
    break if u[:d] >= infinity
    next if determined[u[:id]]
    determined[u[:id]] = 1
    next unless h = edges[u[:id]]
    h.each{ |vid,w|
      vi = vs[vid]
      v = vi[:v]
      next if v[:d] <= u[:d] + w
      v[:d] = u[:d] + w
      #ns.insert(v)
      ns.update_node(vi, v)
      #p ns.head
    }
  end
  $stderr.puts cnt, nodes.size
  vs.values.map{ |v| v[:v] }
end

# TESTCODE 
# nodes = [1, 2, 3, 4, 5, 6]
# edges = {}
# [
#   [1,2,7], [1,3,9], [1,6,14], [2,3,10], [2,4,15], [3,4,11], [3,6,2], [4,5,6], [5,6,9]
# ].each{ |s,t,w|
#   edges[s] ||= {}; edges[t] ||= {}
#   edges[s][t] = edges[t][s] = w
# }

# shortest_undirected_dijkstra(nodes, edges, 1).each{ |n|
#   u = n[:v]
#   id = u[:id]; d = u[:d]
#   path = []
#   while u
#     path << u[:id]
#     u = u[:prev]
#   end
#   p [id, d, path.reverse.join(" -> ")]
# }

N,M,T = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
Nodes = (1..N).to_a
edges = {}
reverse_edges = {}
infinity = 1
M.times {
  s,t,w = gets.split.map(&:to_i)
  edges[s] ||= {}
  reverse_edges[t] ||= {}
  infinity += w
  edges[s][t] = reverse_edges[t][s] = w
}

#edges.each{ |f,h| p [f,h]}
r1,r2 = nil,nil
t1 = Benchmark.realtime do
  r1 = shortest_dfs(Nodes, edges, 1, infinity: infinity).sort_by{ |n| n[:id] }.map{ |n| n[:d] }.inject(:+)
end
t2 = Benchmark.realtime do
  #bd = shortest_dfs(Nodes, reverse_edges, 1, infinity: infinity).sort_by{ |n| n[:id] }.map{ |n| n[:d] }
  r2 = shortest_dijkstra(Nodes, edges, 1, infinity: infinity).sort_by{ |n| n[:id] }.map{ |n| n[:d] }.inject(:+)
end
p r1,r2,r1==r2,t1,t2
# bd = shortest_dijkstra(Nodes, reverse_edges, 1, infinity: infinity).sort_by{ |n| n[:v][:id] }.map{ |n| n[:v][:d] }
#p fd, bd
#puts (0...N).map{ |i| (fd[i] == infinity || bd[i] == infinity) ? 0 : [T - fd[i] - bd[i], 0].max * A[i] }.max
