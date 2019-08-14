module Api
  module ExchangeRates
    module Adapters
      class FixerIoAdapter < BaseAdaptor
        def new
        end

        def time_series(days_back, base_currency, target_currency)
          start_date = Date.today - days_back.days
          end_date = Date.today
          url_params = {
            access_key: ENV['FIXER_API_KEY'],
            start_date: start_date,
            end_date: end_date,
            base: base_currency,
            symbol: target_currency
          }.to_query

          url = URI.parse(
            "#{ENV['FIXER_TIMESERIES_URL']}?#{url_params}"
          )
          req = Net::HTTP::Get.new(url.to_s)
          response = Net::HTTP.start(url.host, url.port) { |http|
            http.request(req)
          }
          response.body
        end

        def historic_rate(date, base_currency, target_currency)
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
          response.body
        end
      end
    end
  end
end
