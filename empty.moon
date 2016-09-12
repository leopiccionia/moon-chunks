empty = (x) ->
  if not x
    return true
  if x == 0 or x == '' or x == '0'
    return true
  if type(x) == 'table'
    for k, v in pairs(x)
      return false
    return true
  return false

blank = (x) ->
  if x == 0 or x == '0'
    return false
  empty(x)

return{empty: empty, blank: blank}
