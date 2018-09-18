# very simple union-find
class UnionFind_Primitive
  attr_reader :parent, :value
  attr_writer :parent

  def initialize(x)
    @value = x
    @parent = self
  end

  def ==(obj)
    @value == obj.value
  end

  def find
    self.parent == self ? self : self.parent.find
  end

  def union(y)
    self.find.parent = y.find
  end
end

# union by rank
class UnionFind_UnionByRank
  attr_reader :rank, :parent, :value
  attr_writer :rank, :parent

  def initialize(x)
    @value = x
    @rank = 0
    @parent = self
  end

  def ==(obj)
    @value == obj.value
  end

  def find
    self.parent == self ? self : self.parent.find
  end

  def union(y)
    xr = find; yr = y.find
    return if xr == yr
    if xr.rank >= yr.rank
      yr.parent = xr
      xr.rank += 1
    else
      y.union(self)
    end
  end
end

# levels with finding
# Verified: https://beta.atcoder.jp/contests/abc065/tasks/arc076_b?lang=en
class UnionFind_PathCompression
  attr_reader :rank, :parent, :value
  attr_writer :rank, :parent

  def initialize(x)
    @value = x
    @rank = 0
    @parent = self
  end

  def ==(obj)
    @value == obj.value
  end

  def find
    return self if self.parent == self
    root = self.parent.find
    self.parent = root
    root
  end

  def union(y)
    xr = find; yr = y.find
    return if xr == yr
    if xr.rank >= yr.rank
      yr.parent = xr
      xr.rank += 1
    else
      y.union(self)
    end
  end
end

# TESTCODE

ufs = (1..400000).map{ |x| UnionFind_PathCompression.new(x) }
#p ufs.map{ |x| x.find.value }
(0...ufs.size/2).each{ |i| ufs[i].union(ufs[i*2]) }
(0...ufs.size-1).each{ |i| ufs[i+1].union(ufs[i]) }
#p ufs.map{ |x| x.find.value }
