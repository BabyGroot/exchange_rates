module Api
  module ExchangeRates
    class AdaptorFactory
      attr_reader :preferred_client

      # @param [String] preferred_client
      def initialize(preferred_client = 'fixer.io')
        @preferred_client = preferred_client
      end

      def time_series(days, base_currency, target_currency)
        client = select_client(select_client(preferred_client))

        client.time_series(days, base_currency, target_currency)
      end

      def historic_rate(date, base_currency, target_currency)
        client = select_client(select_client(preferred_client))

        client.historic_rate(date, base_currency, target_currency)
      end

      private

      def select_client
        case preferred_client
        when 'fixer.io'
          Api::ExchangeRates::Adapters::FixerIoAdapter
        else
          Api::ExchangeRates::Adapters::BaseAdapter # Not configured
        end
      end
    end
  end
end
