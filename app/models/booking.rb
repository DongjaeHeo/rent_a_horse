class Booking < ApplicationRecord
  belongs_to :horse
  belongs_to :user
  validates :start_date, :end_date, presence: true

  validate :end_date_after_start_date?
  # validate :reservations_must_not_overlap


  def confirm!
    self.confirmed = true
    self.save
  end

  private

  def end_date_after_start_date?
    if end_date < start_date
      errors.add :end_date, "must be after start date"
    end
  end


  # def reservations_must_not_overlap
  #   return if self
  #     .class
  #     .where.not(id: id)
  #     .where(horse_id: horse_id)
  #     .where('start_date < ? AND end_date > ?', end_date, start_date)
  #     .none?
  #   errors.add(:base, 'Overlapping reservation exists')
  # end
end
