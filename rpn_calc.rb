class RpnCalculator
  def initialize
  end

  STACK = []
  OPERATORS = {'+'=>:+, '-'=>:-, '/'=>:/, '*'=>:*}

  def prompt
    STDOUT.write "> "
    gets
  end

  def quit
    puts "Good bye!"
    exit
  end

  def calculate(entry)
    entry = entry.strip

    case entry
      when /\d/
        push_to_stack(entry)
      when "-", "/", "*", "+"
        valid_operation?
        evaluate(entry)
      else
        invalid_entry_message
    end
  end

  private

  def push_to_stack(entry)
    STACK.push(entry)
    puts entry
  end

  def valid_operation?
    if STACK.count < 2
      return puts "Invalid operation. Try again!"
    end
  end

  def evaluate(entry)
    operands = STACK.pop(2)
    STACK.push(operands[0].to_f.send(OPERATORS[entry], operands[1].to_f))
    puts trim_float(STACK.last)
  end

  def invalid_entry_message
    puts "Invalid entry. Try again!"
  end

  def trim_float(num)
    i, f = num.to_i, num.to_f
    i == f ? i : f
  end
end

trap ("INT") { puts; quit }

puts "Welcome. Press 'q' to quit."

rpn = RpnCalculator.new

while (code = rpn.prompt)
  case code.strip
  when "q"
    rpn.quit
  else
    rpn.calculate(code)
  end
end
