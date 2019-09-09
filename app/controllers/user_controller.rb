class UserController < ApplicationController
  include CurrencyHelper
  before_action :init

  helper_method :currency_step

  attr_reader :horizontal_axis, :vertical_axis

  def init
    @currencies = AVAILABLE_CURRENCIES
    @current_calculation = nil
    @rates = get_historic_rates
  end

  def show
  end

  def calculate_exchange_rates
    # call service to return calculation

    # Display
  end

  def get_historic_rates
    rates = []
    ExchangeRate.all.each do |rate|
      rates << rate
    end
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
