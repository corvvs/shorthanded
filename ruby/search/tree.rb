
# parse edges of a tree
def parse_tree(number_es)
  es = {}
  number_es.times do
    s,t,w = yield
    es[s] ||= {}; es[t] ||= {}
    es[s][t] = es[t][s] = (w || 1)
  end
  es
end

# scan nodes by dfs; shallower to deeper
def dfs_tree_preorder(start, edges)
  require 'set'
  queue = [start]
  visited = Set[start]
  fromfrom = nil
  while queue.size > 0
    f = queue.pop
    ts = edges[f].keys.reject{ |t| visited.member?(t) }
    yield(f, fromfrom)
    fromfrom = f
    ts.each{ |t| visited << t; queue << t }
  end
end

# scan nodes by dfs; deeper to shallower
def dfs_tree_postorder(start, edges)
  require 'set'
  queue = [[start,nil]]
  visited = Set[start]
  bq = []
  while queue.size > 0
    f = queue.pop
    bq << f
    ts = edges[f[0]].keys.reject{ |t| visited.member?(t) }
    ts.each{ |t| visited << t; queue << [t,f[0]] }
  end
  bq.reverse_each{ |f| yield(*f) }
end

N = $stdin.gets.to_i
es = parse_tree(N-1) { l = $stdin.gets.split; l[2] = l[2].to_i; l[0..1] }
p es
dfs_tree_postorder("a", es) { |n,t| p [t,n] }