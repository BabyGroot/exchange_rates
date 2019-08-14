class CreateCalculations < ActiveRecord::Migration[5.2]
  TABLE_NAME = :calculations
  def up
    unless table_exists? TABLE_NAME
      create_table TABLE_NAME do |t|
        t.integer     :user_id, null: false
        t.integer     :base_amount_subunit, null: false
        t.string      :base_amount_currency, limit: 3, null: false
        t.integer     :target_amount_subunit, null: false
        t.string      :target_amount_currency, limit: 3, null: false
        t.float       :exchange_rate, null: false
        t.date        :date, null: false
      end
    end

    unless index_exists? TABLE_NAME, name: 'Idx UNIQUE on user_id, date, currencies'
      add_index(
        TABLE_NAME,
        [:user_id, :base_amount_currency, :date,  :target_amount_currency],
        name: 'Idx UNIQUE on user_id, date, currencies',
        unique: true
      )
    end
  end

  def down
    if table_exists? TABLE_NAME
      drop_table TABLE_NAME
    end
  end
end
