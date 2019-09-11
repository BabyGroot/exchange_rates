
module Api
  module ExchangeRates
    module Adapters
      class FixerIoAdapter < BaseAdapter

        attr_reader :date, :base_currency, :target_currency

        def initialize(date:, base_currency:, target_currency:)
          @date = date
          @base_currency = base_currency
          @target_currency = target_currency
        end

        # TODO: If my account has access to this API, use it (it's more efficient)
        # def time_series(days_back, base_currency, target_currency)
        #   start_date = Date.today - days_back.days
        #   end_date = Date.today
        #   url_params = {
        #     access_key: ENV['FIXER_API_KEY'],
        #     start_date: start_date,
        #     end_date: end_date,
        #     base: base_currency,
        #     symbol: target_currency
        #   }.to_query

        #   url = URI.parse(
        #     "#{ENV['FIXER_TIMESERIES_URL']}?#{url_params}"
        #   )
        #   req = Net::HTTP::Get.new(url.to_s)
        #   response = Net::HTTP.start(url.host, url.port) { |http|
        #     http.request(req)
        #   }
        #   response.body
        # end

        def historic_rate
          url_params = {
            access_key: ENV['FIXER_API_KEY'],
            base: base_currency,
            symbol: target_currency
          }.to_query

          url = URI.parse(
            "#{ENV['FIXER_BASE_URL']}/#{date}?#{url_params}"
          )

          req = Net::HTTP::Get.new(url.to_s)
          response = Net::HTTP.start(url.host, url.port) { |http|
            http.request(req)
          }

          rates = store_exchange_rate(JSON.parse(response.body))
          rates
        end

        private

        def store_exchange_rate(response)
          ExchangeRate.create!(
            base_currency: base_currency,
            target_currency: target_currency,
            exchange_rate: response['rates'][target_currency],
            date: date
          )
        end
      end
    end
  end
end
