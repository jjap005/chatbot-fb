class Found < ApplicationRecord
  belongs_to :user

  validates :number, presence: true, uniqueness: true
  validates :amount, presence: true, numericality: true
  validates :date, presence: true
  validates :rut, presence: true

  validate :valid_date?

  def valid_date?
    unless date_before_type_cast
      errors.add(:date, 'Formato de fecha no valido')

      return false
    end

    Date.parse(date_before_type_cast)
  end
end
