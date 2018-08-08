
# find an index: max{ i | yield(i) == true  }; O(log(b-a))
def bsearch_int_left(a, b)
  return nil if !yield(a)
  while a < b
    m = a + (b-a+1)/2
    if yield(m)
      a = m
    else
      b = m-1
    end
  end
  a <= b ? a : nil
end

# find a number about to: max{ x | yield(x) == true } within delta; O(log(b-a) - log(delta))
def bsearch_float_left(a, b, delta)
  return nil if !yield(a)
  while b - a >= delta
    m = a + (b-a)/2
    if yield(m)
      a = m
    else
      b = m
    end
  end
  a + (b-a)/2
end

# TESTCODE

#arr = (1..100000).to_a
#puts bsearch_int_left(0, arr.size-1) { |i| arr[i] <= 70000 }

delta = 1E-12
puts bsearch_float_left(0.0, 2.0, delta) { |x| Math.cos(x) >= 0 } * 2 - Math::PI