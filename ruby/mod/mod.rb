def powmod(b,r,mod)
  a = 1
  while r > 0
    if r%2 == 0
      a = a * b % mod
    end
    b = b * b % mod
    r /= 2
  end
  a
end

def factorial(n, mod)
  fs = [1]
  (1..n).each{ |k| fs << (fs[-1] * k) % mod }
  fs
end

# modular-inverse of factorial by mod (assuming prime for every 1..n)
def inv_factorial(n, mod)
  fs = [1]
  f = 1
  (1..n).each{ |k|
    f = f * k % mod
    fs << powmod(f, mod-2, mod)
  }
  fs
end
