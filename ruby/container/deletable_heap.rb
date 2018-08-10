class Deletable_Binary_Heap
  def initialize(&comparator)
    @array = [nil]
    @comparator = comparator
    @m = @array.size
    @position = {}
  end

  def insert(x)
    case 
    when @m < @array.size
      @array[@m] = x
    else
      @array << x
    end
    @position[x] = @m
    up_heap(@m)
    @m += 1
    #p @position
    #p @array[1...@m]
  end

  def up_heap(i)
    while (j = i >> 1) > 0
      return if @comparator.call(@array[j], @array[i])
      @array[i], @array[j] = @array[j], @array[i]
      @position[@array[i]], @position[@array[j]] = @position[@array[j]], @position[@array[i]]
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
    @position[@array[1]] = 1
    @position.delete(@array[@m])
    down_heap(1)
    #p @position
    #p @array[1...@m]
    @array[@m]
  end

  def down_heap(i)
    while (j = i << 1) < @m
      l = j+1 < @m && !@comparator.call(@array[j], @array[j+1]) ? j+1 : j
      return if @comparator.call(@array[i], @array[l])
      @array[i], @array[l] = @array[l], @array[i]
      @position[@array[i]], @position[@array[l]] = @position[@array[l]], @position[@array[i]]
      i = l
    end
  end

  def delete(x)
    #p x
    i = @position[x]
    return unless i
    return unless i < @m
    j = @m - 1
    @array[i], @array[j] = @array[j], @array[i]
    @position[@array[i]] = i
    @position.delete(x)
    @m -= 1
    down_heap(i)
    up_heap(i)
    #p [i, j, @array[1...@m]]; p @position
    x
  end
end

# TESTCODE
heap = Deletable_Binary_Heap.new { |x,y| x >= y }
N = gets.to_i
A = (0..N).to_a.shuffle
A.each{ |x|
  heap.insert(x)
  #p [x, heap.head, heap]
}

arr = []
A.reverse.each { |x|
  arr << heap.delete(x)
}
p A
p arr.reverse
# p (0...arr.size-1).all?{ |i| arr[i] >= arr[i+1] }