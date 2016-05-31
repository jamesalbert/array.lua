local array = require 'array'
local format = string.format

function test(name, func)
  xpcall(function()
    func()
    print(format('[pass] %s', name))
  end, function(err)
    print(format('[fail] %s : %s', name, err))  
  end)
end

function _equal(a, b)
  return a == b
end

function assert_equal(a, b)
  assert(_equal(a, b))
end

test('is_array should returns false when object is not a table', function()
    assert_equal(array.is_array('lua'), false)
end)

test('is_array should returns false when the table is working like a dictionary', function()
    assert_equal(array.is_array({ language='lua' }), false)
end)

test('is_array should returns true when table is empty', function()
    assert_equal(array.is_array({}), true)
end)

test('is_array should returns true when table is working like an array', function()
    assert_equal(array.is_array({ 'a', 'b', 'c', 'd' }), true)
end)

test('is_empty should returns false when table has at least one item', function()
    assert_equal(array.is_empty({ 'a' }), false)
end)

test('is_empty should returns false when table does not have any item', function()
    assert_equal(array.is_empty({}), true)
end)

test('first should returns nil when table is working like a dictionary', function()
    assert_equal(array.first({language='lua'}), nil)
end)

test('first should returns first item from table', function()
    assert_equal(array.first({ 'a', 'b', 'c', 'd' }), 'a')
end)

test('last should returns nil when table is working like a dictionary', function()
    assert_equal(array.last({language='lua'}), nil)
end)

test('last should returns last item from table', function()
    assert_equal(array.last({ 'a', 'b', 'c', 'd' }), 'd')
end)

test('slice should returns a empty table when it does not have any element', function()
    assert_equal(#array.slice({}, 1, 2), 0)
end)

test('slice should returns a table with values between start index and end index', function()
    local result = array.slice({ 'lua', 'javascript', 'python', 'ruby', 'c' }, 2, 4)

    assert_equal(type(result), 'table')
    assert_equal(#result, 3)
    assert_equal(result[1], 'javascript')
    assert_equal(result[2], 'python')
    assert_equal(result[3], 'ruby')
end)

test('slice should returns a table with every values from start index until last index', function()
    local result = array.slice({ 'lua', 'javascript', 'python', 'ruby', 'c' }, 2)

    assert_equal(type(result), 'table')
    assert_equal(#result, 4)
    assert_equal(result[1], 'javascript')
    assert_equal(result[2], 'python')
    assert_equal(result[3], 'ruby')
    assert_equal(result[4], 'c')
end)

test('reverse should returns an inverted table', function()
    local result = array.reverse({ 'lua', 'javascript', 'python' })

    assert_equal(type(result), 'table')
    assert_equal(#result, 3)
    assert_equal(result[1], 'python')
    assert_equal(result[2], 'javascript')
    assert_equal(result[3], 'lua')
end)

test('map should returns a table with 2, 4, 6 values', function()
    local result = array.map({ 1, 2, 3 }, function(value)
        return value * 2
    end)

    assert_equal(type(result), 'table')
    assert_equal(#result, 3)
    assert_equal(result[1], 2)
    assert_equal(result[2], 4)
    assert_equal(result[3], 6)
end)
