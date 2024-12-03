
function Main()
  local input = Read_file("input")
  local mul_pairs = Parse_string(input)
  local output = 0
  for _,pair in ipairs(mul_pairs) do
    output = output +  pair[1] * pair[2]
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
  local output = {}
  for arg1, arg2 in string.gmatch(input, "mul%((%d+),(%d+)%)") do
    table.insert(output, {tonumber(arg1), tonumber(arg2)})
  end
  return output
end

Main()
