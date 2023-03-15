class Horse < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  validates :name, presence: true
  validates :colour, presence: true, inclusion: { in: ['bay', 'chestnut', 'grey', 'black', 'buckskin', 'palomino', 'pinto', 'leopard', 'appaloosa'] }
  validates :breed, presence: true, inclusion: { in: ['arab', 'warmblood', 'pony', 'throughbred', 'icelandic', 'coldblood', 'mustang'] }
  validates :location, presence: true
  validates :discipline, presence: true, inclusion: { in: ['show jumper', 'school master', 'dressage horse', 'general usage', 'eventer', 'rogue', 'driving']}
  validates :height, numericality: { integer: true, less_than_or_equal_to: 220 }
  has_many_attached :photos
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  def available?(from, to)
    bookings.where('start_date <= ? AND end_date >= ?', to, from).none?
  end

end
