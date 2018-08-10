require_relative '../container/updatable_heap'

def shortest_dijkstra(nodes, edges, start)
  infinity = edges.values.map{ |h| h.values.map{ |v| v.abs }.inject(:+) }.inject(:+) + 1
  ns = Updatable_Binary_Heap.new { |s,t| s[:d] <= t[:d] }
  vs = Hash[nodes.map{ |n| [n, ns.insert({ id: n, d: n == start ? 0 : infinity, prev: nil })] }]
  #p ns
  #p vs

  cnt = 0
  while ui = ns.shift
    u = ui[:v]
    edges[u[:id]].each{ |vid,w|
      cnt += 1
      vi = vs[vid]
      v = vi[:v]
      #p [u,v,w]
      if v[:d] > u[:d] + w
        v[:d] = u[:d] + w
        v[:prev] = u
        ns.update_node(vi, v)
      end
    }
  end
  #p cnt

  vs.values
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
M.times {
  s,t,w = gets.split.map(&:to_i)
  edges[s] ||= {}
  reverse_edges[t] ||= {}
  edges[s][t] = reverse_edges[t][s] = w
}

fd = Hash[shortest_dijkstra(Nodes, edges, 1).map{ |n| 
  u = n[:v]
  [u[:id], u[:d]]
}]

bd = Hash[shortest_dijkstra(Nodes, reverse_edges, 1).map{ |n|
  u = n[:v]
  [u[:id], u[:d]]
}]
#p fd, bd
puts Nodes.map{ |i| [T - fd[i] - bd[i], 0].max * A[i-1] }.max
