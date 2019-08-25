require 'net/http'

module Api
  module ExchangeRates
    module Adapters
      class BaseAdapter

        def initialize
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
