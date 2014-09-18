RSpec.configure do |config|
  config.order = :random
  config.fail_fast = true

  config.disable_monkey_patching!

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end
end
