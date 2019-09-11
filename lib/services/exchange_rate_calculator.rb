module Services
  class ExchangeRateCalculator
    # @param [String] - base_currency
    # @param [String] - target_currency
    # @param [Money]  - amount

    attr_accessor :base_currency, :target_currency, :amount

    def initialize(base_currency:, target_currency:, amount:)
      @base_currency = base_currency
      @target_currency = target_currency
      @amount = get_subunit_amount(amount)
    end

    def get_historic_rates(days_back: 25)
      historic_rates = []
      days_back.times do |day|
        date = Date.today - day.days

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
        historic_rates << {
          date: exr.date,
          exchange_rate: exr.exchange_rate
        }
      end
      return historic_rates
    end

    def store_calculation(user:)
      rate = fetch_local_rate(
        base_currency: base_currency,
        target_currency: target_currency,
        date: Date.today
      )
      Calculation.create!(
        user: user,
        base_amount: Money.new(amount, rate.base_currency),
        target_amount: Money.new(
                         calculate_target_amount(
                           amount: amount,
                           exchange_rate: rate.exchange_rate
                         ),
                         rate.target_currency
                       ),
        exchange_rate: rate.exchange_rate,
        date: Date.today
      )
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

    def get_subunit_amount(amount)
      money = Money.new(1, base_currency)
      amount.to_i * money.currency.subunit_to_unit
    end

    def calculate_target_amount(amount:, exchange_rate:)
      (amount * exchange_rate).to_i
    end
  end
end
