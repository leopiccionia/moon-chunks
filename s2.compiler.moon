s2 = {}

-- Type evaluation

s2.is_n = (x) -> tonumber(x) ~= nil

-- Arithmetics

s2.add = (t, i) ->
  if s2.is_n(t[i-1]) and s2.is_n(t[i-2])
    t[i] = tonumber(t[i-1]) + tonumber(t[i-2])
    table.remove(t, i-1)
    table.remove(t, i-2)
    s2.prepare.counter -= 2
    
s2.sub = (t, i) ->
  if s2.is_n(t[i-1]) and s2.is_n(t[i-2])
    t[i] = tonumber(t[i-1]) - tonumber(t[i-2])
    table.remove(t, i-1)
    table.remove(t, i-2)
    s2.prepare.counter -= 2 

s2.mul = (t, i) ->
  if s2.is_n(t[i-1]) and s2.is_n(t[i-2])
    t[i] = tonumber(t[i-1]) * tonumber(t[i-2])
    table.remove(t, i-1)
    table.remove(t, i-2)
    s2.prepare.counter -= 2 

s2.div = (t, i) ->
  if s2.is_n(t[i-1]) and s2.is_n(t[i-2])
    t[i] = tonumber(t[i-1]) / tonumber(t[i-2])
    table.remove(t, i-1)
    table.remove(t, i-2)
    s2.prepare.counter -= 2 

s2.pow = (t, i) ->
  if s2.is_n(t[i-1]) and s2.is_n(t[i-2])
    t[i] = tonumber(t[i-1]) ^ tonumber(t[i-2])
    table.remove(t, i-1)
    table.remove(t, i-2)
    s2.prepare.counter -= 2 

s2.mod = (t, i) ->
  if s2.is_n(t[i-1]) and s2.is_n(t[i-2])
    t[i] = tonumber(t[i-1]) % tonumber(t[i-2])
    table.remove(t, i-1)
    table.remove(t, i-2)
    s2.prepare.counter -= 2 

s2.log = (t, i) ->
  if s2.is_n(t[i-1])
    t[i] = math.log tonumber(t[i-1])
    table.remove(t, i-1)
    s2.prepare.counter -= 1  

-- Parser utils

s2.prepare = {}

s2.prepare.split = (s) ->
  r = {}
  for w in string.gmatch(s, '%S+')
    table.insert(r, w)
  r

s2.prepare.invert = (t) ->
  r = {}
  n = #t
  for i = 1, n
    r[n - i + 1] = t[i]
  r 

s2.prepare.view = (t) ->
  table.concat(s2.prepare.invert(t), " ")

-- Parser itself

s2.parse = (s) ->
  t = s2.prepare.split(s)
  t = s2.prepare.invert(t)
  s2.prepare.counter = #t
  while s2.prepare.counter > 1
    print s2.prepare.view(t)
    for i,v in ipairs(t)
      switch v
        when '+'
          s2.add(t, i)
        when '-'
          s2.sub(t, i)
        when '*'
          s2.mul(t, i)
        when '/'
          s2.div(t, i)
        when '^'
          s2.pow(t, i)
        when '%'
          s2.mod(t, i)
        when 'log'
          s2.log(t, i)
  t[1]

return s2
