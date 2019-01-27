
class SegTree
  attr_reader :original_size, :internal_size, :op

  def initialize(original_size, unit, &op)
    @original_size = original_size
    @op = op
    h = 0
    while (1 << h) < original_size
      h += 1
    end
    @internal_size = (1 << h)
    @height = h
    @array = Array.new((1 << (h+1)) - 1, unit)
  end

  def update(i, val)
    os = 0
    bs = @internal_size
    @array[i] = val
    @height.times do
      j = (os + i) | 1
      val = @op.call(@array[j ^ 1], @array[j])
      i >>= 1
      os |= bs
      bs >>= 1
      @array[os+i] = val
    end
    @array[-1]
  end

  def find(a,b)
    lv = nil; rv = nil
    os = 0
    bs = @internal_size
    while a < b
      if (a&1) == 1
        lv = lv ? @op.call(lv, @array[a]) : @array[a]
        a += 1
      end

      if (b&1) == 0
        rv = rv ? @op.call(@array[b], rv) : @array[b]
        b += -1
      end

      a = ((a-os) >> 1) | os | bs
      b = ((b-os) >> 1) | os | bs
      os |= bs
      bs >>= 1
    end

    if a == b
      lv = lv ? @op.call(lv, @array[a]) : @array[a]
    end
    rv ? @op.call(lv, rv) : lv
  end

  def data
    @array[0...@original_size]
  end

  def fulldata
    @array
  end
end

# https://atcoder.jp/contests/chokudai_S001/submissions/4074504

N,*A = `dd`.split.map &:to_i
st = SegTree.new(N, 0){ |a,b| a > b ? a : b }
A.each{ |a|
  st.update(a-1, st.find(0,a-1) + 1)
}
p st.data.max

