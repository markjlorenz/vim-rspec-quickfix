# Adapted from https://github.com/bronson/vim-runtest/blob/master/rspec_formatter.rb.
# Adopted to RSpec ~> 3 from spec/support/formatters/vim_formatter.rb
require 'rspec/core/formatters/base_text_formatter'

class VimFormatter
  RSpec::Core::Formatters.register self, :example_failed

  def initialize(output)
    @output = output
  end

  def example_failed(examples)
    examples.each do |example|
      exception = example.execution_result.exception
      path = $1 if exception.backtrace.find do |frame|
        frame =~ %r{\b(spec/.*_spec\.rb:\d+)(?::|\z)}
      end
      message = format_message exception.message
      #path    = format_caller path
      @output.puts "#{path}: #{example.example_group.description.strip} " +
        "#{example.description.strip}: #{message.strip}" if path
    end
  end

  def example_pending *args;  end
  def dump_failures *args; end
  def dump_pending *args; end
  def message msg; end
  def dump_summary *args; end
  def seed *args; end

private

  def format_message msg
    msg.gsub("\n", ' ')[0,80]
  end
end
