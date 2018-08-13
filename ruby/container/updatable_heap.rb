class Updatable_Binary_Heap
  def initialize(list: [], &pred)
    @a = [nil] + list.sort{ |a,b| pred.call(a,b) ? -1 : 1 }.map.with_index{ |v,i| { i: i+1, v: v }  }
    @pred = pred
    @m = @a.size
  end

  def insert(x)
    node = { i: @m, v: x }
    case 
    when @m < @a.size
      @a[@m] = node
    else
      @a << node
    end
    up_heap(@m)
    @m += 1
    node
  end

  def up_heap(i)
    while (j = i >> 1) > 0
      break if @pred.call(@a[j][:v], @a[i][:v])
      swap_node(i,j)
      i = j
    end
    i
  end

  def head
    @a[@m > 1 ? 1 : 0]
  end

  def shift
    return nil if @m <= 1
    @m -= 1
    swap_node(1, @m)
    down_heap(1)
    @a[@m]
  end

  def down_heap(i)
    while (j = i << 1) < @m
      j |= ((j|1) < @m && !@pred.call(@a[j][:v], @a[j|1][:v])) ? 1 : 0
      break if @pred.call(@a[i][:v], @a[j][:v])
      swap_node(i,j)
      i = j
    end
    i
  end

  def swap_node(i,j)
    @a[i][:i], @a[j][:i] = @a[j][:i], @a[i][:i]
    @a[i], @a[j] = @a[j], @a[i]
  end

  def update_node(node, x)
    i = node[:i]
    node[:v] = x
    down_heap(i) == i && up_heap(i)
  end

  def a
    @a[1...@m]
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
# #p heap.a
# heap.update_node(nodes[0], -100)
# #p heap.a
# p nodes[0]
