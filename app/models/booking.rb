class Booking < ActiveRecord::Base
  belongs_to :flight
  belongs_to :user
  has_many :passengers, dependent: :destroy
  before_create :set_code
  before_save :set_price
  validates :flight, allow_nil: false, presence: true
  validates :passengers, presence: true
  accepts_nested_attributes_for :passengers,
                                reject_if: :all_blank,
                                allow_destroy: true

  private

  def set_code
    raw = [("A".."Z"), (0..9)].map(&:to_a).flatten
    self.booking_code = (0...10).map { raw[rand(raw.length)] }.join
  end

  def set_price
    self.price = flight.price * passengers.size
  end
end
