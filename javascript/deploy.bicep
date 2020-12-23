param customRpId string

var jsStringArray = [
  'function fibonacci_recursive(n) {'
  '  if (n === 0 || n === 1) {'
  '    return n;'
  '  }'
  ''
  '  return fibonacci_recursive(n - 2) + fibonacci_recursive(n - 1);'
  '}'
  ''
  'fibonacci_recursive(30)'
]

var jsString = json(replace(string(jsStringArray), '","', '\n'))[0]

output output int = listExecuteJs(customRpId, '2018-09-01-preview', jsString).result