class UserController < ApplicationController
  include CurrencyHelper
  DEFAULT_CURRENCY = 'EUR'
  before_action :init

  helper_method :currency_step

  attr_reader :horizontal_axis, :vertical_axis

  def init
    @user = User.friendly.find(session[:user_id])
    @currencies = AVAILABLE_CURRENCIES
    @rates = get_historic_rates
    @calculations = @user.calculations
  end

  def show
  end

  def calculate_exchange_rates
    # call service to return calculation

    # Display
  end

  def get_historic_rates
    # service = Services::ExchangeRateCalculator.new(
    #             base_currency: DEFAULT_CURRENCY, # Having issues with Fixer.io API, so locking down base currency
    #             target_currency: currency,
    #             amount: amount
    #           )
    # @rates = service.get_historic_calculation
    # rates = []
    # ExchangeRate.all.each do |rate|
    #   rates << rate
    # end
    ExchangeRate.all
  end


  private

  def calculate_params
    @create_params ||=
      begin
        params.require(:amount)
        params.require(:currency)

        params.permit(
          :amount,
          :currency
        )
      end
  end
end
