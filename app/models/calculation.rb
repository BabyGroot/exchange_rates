class User < ApplicationRecord
    BASE_CURRENCY = 'EUR' # Free plan for Fixer.io doesn't support some currencies (Locking down to EUR)
end

