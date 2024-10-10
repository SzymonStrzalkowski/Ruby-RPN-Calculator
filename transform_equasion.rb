def pop_off_stack
  until @stack.empty?
    last_on_stack = @stack.pop
    if last_on_stack == "("
      break
    else
      @output << last_on_stack
    end
  end
end

def check_character(character)
  priorities = {
    '(' => 0,
      '+' => 1, '-' => 1, ')' => 1,
     '*' => 2, '/' => 2, '%' => 2,
     '^' => 3
  }
  case
  when character =~ /\d/ 
    @buffer += character
    return
    # to work with floats
  when @had_a_dot == false && character == "."
    @buffer += character
    @had_a_dot = true
    return
  when priorities.key?(character) || character == "="
    if !@buffer.empty? then
    @output << @buffer.to_f
    @buffer = ""
    @had_a_dot = false
    end
    return true if character == "="
    if @stack.empty? then
      @stack << character
      return
    end
    if character == "("
      @stack << character  # Push opening parenthesis onto stack
      return
    end
    if character == ")"
      pop_off_stack  # Handle closing parenthesis
      return
    end
    if priorities.fetch(character) > priorities.fetch(@stack.last)
      @stack << character
      return
    else
      @output << @stack.pop
      @stack << character
      return
    end
  else
    return
  end
end
