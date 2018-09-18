# https://topcoder.g.hatena.ne.jp/iwiwi/20131226/1388062106
# Verified: https://beta.atcoder.jp/contests/abc075/submissions/3221133
# Verified?: https://beta.atcoder.jp/contests/soundhound2018-summer-final/submissions/3221392
class FUnionFind
  attr_reader :nodes, :parents, :ranks

  def initialize(n)
    @parents = (0...n).to_a
    @nodes = @parents.map{ |x| [x] }
  end

  def find(i)
    @parents[i]
  end

  def union(i,j)
    i = @parents[i]; j = @parents[j]
    return if i == j
    j,i = i,j if @nodes[i].size < @nodes[j].size
    #p [i,j,@nodes[i],@nodes[j]]
    #p [i,j,@nodes[i].size,@nodes[j].size]
    @nodes[j].each{ |k| @parents[k] = i }
    @nodes[i].concat(@nodes[j])
    @nodes[j].clear
  end
end

# TESTCODE
N = 100000
Xs = (0..N).to_a
UF = FUnionFind.new(N)
p UF.find(Xs[0])
p UF.find(Xs[-1])
(1..N).each{ |i|
  UF.union(i-1,i)
}
p UF.find(Xs[0])
p UF.find(Xs[-1])
