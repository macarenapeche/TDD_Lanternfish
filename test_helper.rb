
class ExpectationNotMetError < StandardError
end

def assert_equal(message = "ok", expected, &actual)
  result = actual.call

  raise ExpectationNotMetError, "Expected #{expected.inspect}, got #{result.inspect}" if result != expected

  puts message
rescue ExpectationNotMetError => e
  puts "  #{e}"
  puts e.backtrace[1..].map { |line| "    #{line}" }
end

def assert_error(klass, &actual)
  begin
    actual.call
  rescue => e
    raise ExpectationNotMetError, "Expected '#{e}' to be an instance of #{klass}, but got #{e.class}" if e.class != klass
    puts "ok"
  else
    puts "Expected #{klass} error to be raisen, but nothing was raised"
  end
rescue ExpectationNotMetError => e
  puts e
  puts e.backtrace[2..].map { |line| "  #{line}" }
end
