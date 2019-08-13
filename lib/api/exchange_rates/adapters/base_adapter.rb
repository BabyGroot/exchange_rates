require 'net/http'
module Api
  module ExchangeRates
    module Adapters
      class BaseAdapter
        def self.time_series(_days_back, _base_currency, _target_currency)
          raise NotImplementedError
        end

        def self.historic_rate(_date, _base_currency, _target_currency)
          raise NotImplementedError
        end
      end
    end
  end
end
