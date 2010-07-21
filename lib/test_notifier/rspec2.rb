require 'test_notifier'
require 'rspec/core/formatters/base_text_formatter'

class Rspec::Core::Formatters::BaseTextFormatter
  alias summary_line_original summary_line

  def summary_line(example_count, failure_count, pending_count)
    summary_line_original(example_count, failure_count, pending_count)

    begin
      return if examples == 0

      if failure_count > 0
        title = TestNotifier::FAILURE_TITLE
        image = TestNotifier::ERROR_IMAGE
      else
        title = TestNotifier::PASSED_TITLE
        image = TestNotifier::PASSED_IMAGE
      end

      message = "#{example_count} examples, #{failure_count} failed, #{pending_count} pending"
      TestNotifier::notify(image, title, message)
    rescue
    end
  end
end
