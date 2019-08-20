MoneyRails.configure do |config|
  config.no_cents_if_whole = false
  # Newer versions of Money Gem requires explicit behaviour for localization
  # https://github.com/RubyMoney/money#deprecation
  Money.locale_backend = :i18n
  I18n.locale = :en
end
