class Expense < ApplicationRecord
  validates :category, presence: true
  validates :money , presence: true
  
end
