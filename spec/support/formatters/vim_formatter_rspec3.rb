# Adapted from https://github.com/bronson/vim-runtest/blob/master/rspec_formatter.rb.
# Adopted to RSpec ~> 3 from spec/support/formatters/vim_formatter.rb
require 'rspec/core/formatters/base_text_formatter'

class VimFormatter
  RSpec::Core::Formatters.register self, :example_failed

  def initialize(output)
    @output = output
  end

  def example_failed(notification)
    @output << format(notification) + "\n"
  end

  private

  def format(notification)
    rtn = "%s: %s" % [notification.example.location, notification.exception.message]
    rtn.gsub("\n", ' ')[0,80]
  end
end
