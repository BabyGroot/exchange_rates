module Api
  module ExchangeRates
    class AdaptorFactory
      attr_reader :client

      # @param [String] preferred_client
      def initialize(preferred_client = 'fixer.io')
        @preferred_client = preferred_client
        @client = select_client
      end

      private

      def select_client
        case @preferred_client
        when 'fixer.io'
          Api::ExchangeRates::Adapters::FixerIoAdapter
        else
          Api::ExchangeRates::Adapters::BaseAdapter # Not configured
        end
      end
    end
  end
end
