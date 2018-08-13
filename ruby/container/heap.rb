class Simple_Binary_Heap
  def initialize(&pred)
    @a = [nil]
    @pred = pred
    @m = @a.size
  end

  def insert(x)
    case 
    when @m < @a.size
      @a[@m] = x
    else
      @a << x
    end
    up_heap(@m)
    @m += 1
  end

  def up_heap(i)
    while (j = i >> 1) > 0
      return if @pred.call(@a[j], @a[i])
      @a[i], @a[j] = @a[j], @a[i]
      i = j
    end
  end

  def head
    @a[@m > 1 ? 1 : 0]
  end

  def shift
    return nil if @m <= 1
    @m -= 1
    @a[1], @a[@m] = @a[@m], @a[1]
    down_heap(1)
    @a[@m]
  end

  def down_heap(i)
    while (j = i << 1) < @m
      l = j+1 < @m && !@pred.call(@a[j], @a[j+1]) ? j+1 : j
      return if @pred.call(@a[i], @a[l])
      @a[i], @a[l] = @a[l], @a[i]
      i = l
    end
  end
end

# TESTCODE
heap = Simple_Binary_Heap.new { |x,y| x >= y }
N = gets.to_i
(0..N).to_a.shuffle.each{ |x|
  heap.insert(x)
  #p [x, heap.head, heap]
}

arr = []
while heap.head
  arr << heap.shift
end

p (0...arr.size-1).all?{ |i| arr[i] >= arr[i+1] }