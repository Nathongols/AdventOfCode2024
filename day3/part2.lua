local regex = require('regex')

function Main()
  local input = Read_file("input")
  local mul_pairs = Parse_string(input)
  local output = 0
  local do_flag = true
  for _, val in pairs(mul_pairs) do
    if val == "do()" then
      do_flag = true
    elseif val == "don't()" then
      do_flag = false
    elseif do_flag then
      local x,y
      for arg1, arg2 in string.gmatch(val, '(%d+),(%d+)') do
          x = tonumber(arg1)
          y = tonumber(arg2)
      end
      output = output + x * y
    end
  end
  print(output)
end

function Read_file(file_path)
  local f = assert(io.open(file_path, "rb"))
  local content = f:read("*all")
  f:close()
  return content
end

function Parse_string(input)
  local re = assert(regex.new('mul\\(\\d+,\\d+\\)|don\'t\\(\\)|do\\(\\)'))
  local output, err = re:matches(input)
  return output
end

Main()
