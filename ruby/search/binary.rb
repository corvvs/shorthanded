
# find an index: max{ i | yield(i, array) == true  }
def bsearch_lefting(array)
  return -1 if !yield(0, array)
  a,b = 0,array.size-1
  while a < b
    m = a + (b-a+1)/2
    if yield(m, array)
      a = m
    else
      b = m-1
    end
  end
  a <= b ? a : -1
end

# TESTCODE
puts bsearch_lefting((1..100000).to_a) { |i,arr| arr[i] <= 70000 }