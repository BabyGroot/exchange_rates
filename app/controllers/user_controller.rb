class UserController < ApplicationController
  include CurrencyHelper
  DEFAULT_CURRENCY = 'EUR'
  before_action :init

  helper_method :currency_step

  attr_reader :horizontal_axis, :vertical_axis

  def init
    @user = User.friendly.find(session[:user_id])
    @currencies = AVAILABLE_CURRENCIES
    @calculations = @user.calculations.recent_first
    @rates = ExchangeRate.where(target_currency: 'CAD').all #params['rates']
  end

  def show
  end

  def calculate_exchange_rates
    get_historic_rates_and_store_calculation
    respond_to do |format|
      format.html {
        redirect_to user_path(@user.hash_id, rates: @rates), notice: 'Calculation Success'
      }
    end
  end

  def get_historic_rates_and_store_calculation
    service = ::Services::ExchangeRateCalculator.new(
                base_currency: DEFAULT_CURRENCY, # Having issues with Fixer.io API, so locking down base currency
                target_currency: calculate_params['currency'],
                amount: calculate_params['amount']
              )
    @rates = service.get_historic_rates
    service.store_calculation(user: @user)
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
