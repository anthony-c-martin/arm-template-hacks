var multilineStringArr = [
  'hello'
  'this'
  'is'
  'a'
  'multiline'
  'string'
]

var multilineString = json(replace(string(multilineStringArr), '","', '\n'))[0]

output test string = multilineString