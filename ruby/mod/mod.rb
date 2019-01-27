# returns b^r % mod; O(log(r))
def powmod(b,r,mod)
  a = 1
  while r > 0
    if r%2 == 1
      a = a * b % mod
    end
    b = b * b % mod
    r /= 2
  end
  a
end

def invmod(f, mod)
  powmod(f, mod-2, mod)
end

# returns [0!, 1!, ... , n!]; O(n)
def factorial(n, mod)
  fs = [1]
  (1..n).each{ |k| fs << (fs[-1] * k) % mod }
  fs
end

# modular-inverse of factorial by mod (assuming prime for every 1..n); O(n * log(mod))
def inv_factorial(n, mod)
  fs = [1]
  f = 1
  (1..n).each{ |k|
    f = f * k % mod
    fs << invmod(f, mod)
  }
  fs
end

# TESTCODE
p     factorial(10, 1000000007)
p inv_factorial(10, 1000000007)
