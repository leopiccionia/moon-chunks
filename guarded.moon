-- Read more: https://www.cs.utexas.edu/users/EWD/transcriptions/EWD04xx/EWD418.html

guarded = {}

ABORT_SIGNAL = 0xAB0

guarded.if = (guards) ->
  _positives = {}
  for _, guard in ipairs(guards)
    if guard[1]!
      table.insert(_positives, guard[2])
  if #_positives > 0
    _positives[math.random(#_positives)]!

guarded.do = (guards) ->
  _matches = -1
  while _matches ~= 0
    _positives = {}
    for _, guard in ipairs(guards)
      if guard[1]!
        table.insert(_positives, guard[2])
    _matches = #_positives
    if _matches > 0
      if _positives[math.random(_matches)]! == ABORT_SIGNAL
        return

guarded.skip = ->
guarded.abort = -> ABORT_SIGNAL
guarded.true = -> true

--return guarded

-- If test

a, b, max = 5, 10, nil

guarded.if{
  {(-> a >= b), (-> max = a)}
  {(-> b >= a), (-> max = b)}
}

print max

-- Do test: Euclidean Algorithm

a, b = 20, 80

guarded.do{
  {(-> a < b), (-> b -= a)}
  {(-> b < a), (-> a -= b)}
}

print table.concat{a,' = ',b}

-- Test: Sort four numbers

q1, q2, q3, q4 = 40, 100, 30, 20

guarded.do{
  {(-> q1 > q2), (-> q1, q2 = q2, q1)}
  {(-> q2 > q3), (-> q2, q3 = q3, q2)}
  {(-> q3 > q4), (-> q3, q4 = q4, q3)}
}

print table.concat{q1,' < ',q2,' < ',q3,' < ',q4}