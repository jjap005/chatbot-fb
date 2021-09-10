class Found < ApplicationRecord
  belongs_to :user

  validates :receipt_number, presence: true, uniqueness: true
  validates :amount, presence: true, numericality: true
  validates :date_receipt, presence: true
end
