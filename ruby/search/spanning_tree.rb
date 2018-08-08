require_relative '../struct/unionfind'

def minimum_spanning_tree_kruskal(nodes, edges)
  # edges: [[node_from, node_to, weight]]
  edges.sort_by!{ |e| e[2] }
  th = Hash[nodes.map{ |x| [x, UnionFind_PathCompression.new(x)] }]
  i = 0
  mst = []
  while i < edges.size
    e = edges[i]
    i += 1
    f,t,w = *e
    tf = th[f]; tt = th[t]
    next if (tf.find == tt.find)
    tf.union(tt)
    mst << e
  end
  mst
end

def minimum_spanning_tree_boruvka(nodes, edges)
  # edges: [[node_from, node_to, weight]]
  th = Hash[nodes.map{ |x| [x, UnionFind_PathCompression.new(x)] }]
  es = Hash[edges.map.with_index{ |e,i| [i,e] }]
  mst = []
  while true
    shortest_es = {}
    es.each{ |i,e|
      f,t,w = *e
      tf = th[f]; tt = th[t]
      next if tf.find == tt.find
      shortest_es[f] = [shortest_es[f] || i, i].min{ |i| es[i][2] }
      shortest_es[t] = [shortest_es[t] || i, i].min{ |i| es[i][2] }
    }
    break if shortest_es.size == 0

    shortest_es.each{ |node,i|
      e = es[i]
      next unless e
      tf = th[e[0]]; tt = th[e[1]]
      tf.union(tt)
      mst << e
      es.delete(i)
    }
  end
  mst
end

p minimum_spanning_tree_boruvka([1,2,3], [ [1,2,101], [2,3,102], [3,1,100] ])