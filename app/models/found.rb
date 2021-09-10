class Found < ApplicationRecord
  belongs_to :user

  validates :number, presence: true, uniqueness: true
  validates :amount, presence: true, numericality: true
  validates :date, presence: true
  validates :rut, presence: true

  validate :valid_date?

  def valid_date?
    if self.date_before_type_cast
      begin
        Date.parse(self.date_before_type_cast)
      rescue
        self.errors.add(:date, "Formato de fecha no valido")
      end
    end
  end
end
