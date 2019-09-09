class RenameColumnsOnExchangeRates < ActiveRecord::Migration[5.2]
  TABLE_NAME = :exchange_rates
  def up
    if table_exists? TABLE_NAME
      if column_exists? TABLE_NAME, :base_amount_currency
        rename_column TABLE_NAME, :base_amount_currency, :base_currency
      end

      if column_exists? TABLE_NAME, :target_amount_currency
        rename_column TABLE_NAME, :target_amount_currency, :target_currency
      end
    end
  end

  def down
    if table_exists? TABLE_NAME
      if column_exists? TABLE_NAME, :base_currency
        rename_column TABLE_NAME, :base_currency, :base_amount_currency
      end

      if column_exists? TABLE_NAME, :target_currency
        rename_column TABLE_NAME, :target_currency, :target_amount_currency
      end
    end
  end
end
