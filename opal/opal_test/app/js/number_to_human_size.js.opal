require 'active_support/core_ext/hash/keys'
require 'active_support/number_helper/number_converter'
require 'active_support/number_helper/number_to_human_size_converter'
require 'active_support/number_helper/number_to_rounded_converter'
require 'active_support/number_helper/number_to_delimited_converter'
require 'math'

module ActiveSupport
  module NumberHelper
    class NumberToDelimitedConverter
      private

        def parts
          left, right = number.to_s.split('.')
          left = left.gsub(DELIMITED_REGEX) do |digit_to_delimit|
            "#{digit_to_delimit}#{options[:delimiter]}"
          end
          [left, right].compact
        end
    end
  end
end

module ActiveSupport
  module NumberHelper
    class << self
      def number_to_human_size(size, options = {})
        ActiveSupport::NumberHelper::NumberToHumanSizeConverter.convert(size, options)
      end
    end
  end
end
