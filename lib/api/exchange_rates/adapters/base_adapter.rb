require 'net/http'

module Api
  module ExchangeRates
    module Adapters
      class BaseAdapter

        attr_reader :date, :base_currency, :target_currency

        def initialize(date:, base_currency:, target_currency:)
          @date = date
          @base_currency = base_currency
          @target_currency = target_currency
        end

        def time_series(_days_back, _base_currency, _target_currency)
          raise NotImplementedError
        end

        def historic_rate(_date, _base_currency, _target_currency)
          raise NotImplementedError
        end
      end
    end
  end
end
