module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice' then "alert alert-info"
    when 'success' then "alert alert-success"
    when 'error' then "alert alert-danger"
    when 'alert' then "alert alert-warning"
    end
  end

  # Render money objects with either symbol or iso_code depending on context but symbol by default
  # @param [Money] value
  # @param [String] render_option, options: symbol, iso_code, default: symbol
  def render_money(value, render_option = 'symbol')
    return " - " if value.nil?
    valid_render_options = ['symbol', 'iso_code']

    raise ArgumentError, "Not a Money object" unless value.is_a?(Money)
    raise ArgumentError, "#{render_option} not a valid render option" unless valid_render_options.include?(render_option)

    # Absolute value before converting to string
    formatted_amount = value.abs.format(symbol: value.currency.send(render_option) + ' ', # prepends with currency and space
                                        thousands_separator: ' ', # adds a space between every thousand
                                       )
    if value.negative?
      render_amount = "(#{formatted_amount})" # wrap value in parenthesis if negative
    else
      render_amount = formatted_amount
    end

    render_amount
  end
end
