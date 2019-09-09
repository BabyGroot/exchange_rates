module Services
  class ExchangeRateCalculator
    # @param [String] - base_currency
    # @param [String] - target_currency
    # @param [Money]  - amount

    attr_accessor :base_currency, :target_currency, :amount

    def initialize(base_currency:, target_currency:, amount:)
      @base_currency = base_currency
      @target_currency = target_currency
      @amount = amount
    end

    def get_historic_calculation(days_back: 25)
      historic_rates = {}
      1..days_back.times do |day|
        date = Date.today - (day + 1).days

        exr = fetch_local_rate(
                base_currency: base_currency,
                target_currency: target_currency,
                date: date
              ) ||
              fetch_external_rate(
                base_currency: base_currency,
                target_currency: target_currency,
                date: date
              )
        historic_rates[:date] = exr.exchange_rate
      end
    end

    def calculation
    end

    private

    def fetch_local_rate(base_currency:, target_currency:, date:)
      ExchangeRate.where(
        base_currency: base_currency,
        target_currency: target_currency,
        date: date
      ).last
    end

    def fetch_external_rate(preferred_client: nil, base_currency:, target_currency:, date:)
      exchange_rate_client = Api::ExchangeRates::AdapterFactory
                               .new(preferred_client)
                               .client
      exchange_rate_client
        .new(date: date, base_currency: base_currency, target_currency: target_currency)
        .historic_rate
    end
  end
end
