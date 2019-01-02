# https://github.com/puma/puma/issues/1582
# https://gist.github.com/2rba/74d57775ac83ffcb0ff1da5eb5371212

module CoreExtensions
  module Puma
    module Reactor
      def calculate_sleep
        if @timeouts.empty?
          @sleep_for = ::Puma::Reactor::DefaultSleepFor
        else
          diff = @timeouts.first.timeout_at.to_f - Time.now.to_f

          if diff < 0.0
            @sleep_for = 0
          elsif diff > 60
            @sleep_for = ::Puma::Reactor::DefaultSleepFor
          else
            @sleep_for = diff
          end
        end
      end
    end
  end
end