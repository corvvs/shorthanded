class Simple_Binary_Heap
  def initialize(&comparator)
    @array = [nil]
    @comparator = comparator
    @m = @array.size
  end

  def insert(x)
    case 
    when @m < @array.size
      @array[@m] = x
    else
      @array << x
    end
    up_heap(@m)
    @m += 1
  end

  def up_heap(i)
    while (j = i >> 1) > 0
      return if @comparator.call(@array[j], @array[i])
      @array[i], @array[j] = @array[j], @array[i]
      i = j
    end
  end

  def head
    @array[@m > 1 ? 1 : 0]
  end

  def shift
    return nil if @m <= 1
    @m -= 1
    @array[1], @array[@m] = @array[@m], @array[1]
    down_heap(1)
    @array[@m]
  end

  def down_heap(i)
    while (j = i << 1) < @m
      l = j+1 < @m && !@comparator.call(@array[j], @array[j+1]) ? j+1 : j
      return if @comparator.call(@array[i], @array[l])
      @array[i], @array[l] = @array[l], @array[i]
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