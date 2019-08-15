class UserController < ApplicationController
  include CurrencyHelper
  before_action :init

  def init
    @currencies = AVAILABLE_CURRENCIES
  end

  def show
  end
end
