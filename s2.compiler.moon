s2 = {}

-- Type evaluation

s2.is_n = (x) -> tonumber(x) ~= nil

-- Arithmetics

s2.add = (t, i) ->
  if s2.is_n(t[i-1]) and s2.is_n(t[i-2])
    t[i] = tonumber(t[i-1]) + tonumber(t[i-2])
    s2.remove(t, i, 2)

s2.sub = (t, i) ->
  if s2.is_n(t[i-1]) and s2.is_n(t[i-2])
    t[i] = tonumber(t[i-1]) - tonumber(t[i-2])
    s2.remove(t, i, 2)

s2.mul = (t, i) ->
  if s2.is_n(t[i-1]) and s2.is_n(t[i-2])
    t[i] = tonumber(t[i-1]) * tonumber(t[i-2])
    s2.remove(t, i, 2)

s2.div = (t, i) ->
  if s2.is_n(t[i-1]) and s2.is_n(t[i-2])
    t[i] = tonumber(t[i-1]) / tonumber(t[i-2])
    s2.remove(t, i, 2)

s2.pow = (t, i) ->
  if s2.is_n(t[i-1]) and s2.is_n(t[i-2])
    t[i] = tonumber(t[i-1]) ^ tonumber(t[i-2])
    s2.remove(t, i, 2)

s2.mod = (t, i) ->
  if s2.is_n(t[i-1]) and s2.is_n(t[i-2])
    t[i] = tonumber(t[i-1]) % tonumber(t[i-2])
    s2.remove(t, i, 2)

s2.log = (t, i) ->
  if s2.is_n(t[i-1])
    t[i] = math.log tonumber(t[i-1])
    s2.remove(t, i, 1)

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

s2.remove = (t, start, count) ->
  for i = 1, count
    table.remove(t, start - i)
  s2.prepare.counter -= count

-- Parser itself

OPERATIONS = {
  '+': s2.add,
  '-': s2.sub,
  '*': s2.mul,
  '/': s2.div,
  '^': s2.pow,
  '%': s2.mod,
  'log': s2.log
}

s2.parse = (s) ->
  t = s2.prepare.split(s)
  t = s2.prepare.invert(t)
  s2.prepare.counter = #t
  while s2.prepare.counter > 1
    print s2.prepare.view(t)
    for i,v in ipairs(t)
      if OPERATIONS[v] ~= nil
        OPERATIONS[v](t, i)
  t[1]

-- print s2.parse "+ 5 * 3 2"

return s2