class Updatable_Binary_Heap
  def initialize(&comparator)
    @array = [nil]
    @comparator = comparator
    @m = @array.size
  end

  def insert(x)
    node = { i: @m, v: x }
    case 
    when @m < @array.size
      @array[@m] = node
    else
      @array << node
    end
    up_heap(@m)
    @m += 1
    node
  end

  def up_heap(i)
    while (j = i >> 1) > 0
      return if @comparator.call(@array[j][:v], @array[i][:v])
      swap_node(i,j)
      i = j
    end
  end

  def head
    @array[@m > 1 ? 1 : 0]
  end

  def shift
    return nil if @m <= 1
    @m -= 1
    swap_node(1, @m)
    down_heap(1)
    @array[@m]
  end

  def down_heap(i)
    while (j = i << 1) < @m
      l = j+1 < @m && !@comparator.call(@array[j][:v], @array[j+1][:v]) ? j+1 : j
      return if @comparator.call(@array[i][:v], @array[l][:v])
      swap_node(i,l)
      i = l
    end
  end

  def swap_node(i,j)
    @array[i][:i], @array[j][:i] = @array[j][:i], @array[i][:i]
    @array[i], @array[j] = @array[j], @array[i]
  end

  def update_node(node, x)
    i = node[:i]
    node[:v] = x
    down_heap(i)
    up_heap(i)
  end

  def array
    @array[1...@m].map{ |n| n[:v]}
  end
end

# TESTCODE
# heap = Updatable_Binary_Heap.new { |x,y| x <= y }
# N = gets.to_i
# nodes = (0..N).to_a.shuffle.map{ |x|
#   heap.insert(x)
#   #p [x, heap.head, heap]
# }

# p nodes[0]
# #p nodes.sort_by{ |n| n[:i] }.map{ |n| n[:v] }
# #p heap.array
# heap.update_node(nodes[0], -100)
# #p heap.array
# p nodes[0]
