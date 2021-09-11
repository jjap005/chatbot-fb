class RequestPaper < ApplicationRecord
  PAPER_VALUE = 700

  validates :rut, presence: true
  validates :count, presence: true, numericality: true
  validates :address, presence: true

  validate :valid_balance?
  validate :valid_rut?

  def valid_rut?
    found = Found.find_by(rut: ut)
    return true if found.present?

    false
  end

  def valid_balance?
    founds = Found.where(rut: rut, date: (Time.now + 1.day).strftime('%d/%m/%Y'))

    if founds.empty?
      errors.add(:count, 'Saldo insuficiente, no existen depositos para el dia de mañana.')

      return false
    end

    amount = founds.sum(:amount)
    return true if (count * PAPER_VALUE) > amount

    errors.add(:count, "Saldo insuficiente, cantidad de rollos de papel sobre pasa el monto acumulado de: #{amount}")
    false
  end
end
