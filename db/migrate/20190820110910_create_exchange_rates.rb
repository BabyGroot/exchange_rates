class CreateExchangeRates < ActiveRecord::Migration[5.2]
  TABLE_NAME = :exchange_rates
  def up
    unless table_exists? TABLE_NAME
      create_table TABLE_NAME do |t|
        t.string      :base_amount_currency, limit: 3, null: false
        t.string      :target_amount_currency, limit: 3, null: false
        t.float       :exchange_rate, null: false
        t.date        :date, null: false
        t.timestamps
      end
    end

    unless index_exists? TABLE_NAME, name: 'Idx UNIQUE on exchange pair for date'
      add_index(
        TABLE_NAME,
        [:base_amount_currency, :target_amount_currency, :date],
        name: 'Idx UNIQUE on exchange pair for date'
      )
    end
  end

  def down
    if table_exists? TABLE_NAME
      drop_table TABLE_NAME
    end
  end
end
