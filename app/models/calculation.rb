class Calculation < ApplicationRecord

  monetize :base_amount_subunit, as: "base_amount"
  monetize :target_amount_subunit, as: "target_amount"
  belongs_to :user
end

