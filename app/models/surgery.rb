class Surgery < ApplicationRecord
  has_many :doctor_surgeries
  has_many :doctors, through: :doctor_surgeries

  def find_others
    Surgery.where(day: self.day).where.not(id: id)
  end
end
