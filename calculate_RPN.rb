def overwrite_element(i, value)
  @calculation_stack[i] = value
end
def delete_elements_and_move_index(i)
  @calculation_stack.delete_at(i)
  @calculation_stack.delete_at(i-1)
  return i-2
end
def get_elements(i)
  return @calculation_stack[i-2], @calculation_stack[i-1]
end

def calculate(output_stack)
  i=2
  @calculation_stack = output_stack
  while i<@calculation_stack.length
    element_one, element_two = get_elements(i)
    case @calculation_stack[i]
    when "+"
      overwrite_element(i-2, element_one + element_two)
      i = delete_elements_and_move_index(i)
    when "-"
      overwrite_element(i-2, element_one - element_two)
      i = delete_elements_and_move_index(i)
    when "/"
      overwrite_element(i-2, element_one / element_two)
      i = delete_elements_and_move_index(i)
    when "*"
      overwrite_element(i-2, element_one * element_two)
      i = delete_elements_and_move_index(i)
    when "%"
      overwrite_element(i-2, element_one % element_two)
      i = delete_elements_and_move_index(i)
    when "^"
      overwrite_element(i-2, element_one ** element_two)
      i = delete_elements_and_move_index(i)
    else 
      i = i+1
    end
  end
  return @calculation_stack[0]
end
