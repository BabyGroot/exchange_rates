class UserController < ApplicationController
  include CurrencyHelper
  before_action :init

  helper_method :currency_step

  def init
    @currencies = AVAILABLE_CURRENCIES
    @current_calculation = nil
  end

  def show
  end

  def calculate_exchange_rates
    # call service to return calculation

    # Display
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
