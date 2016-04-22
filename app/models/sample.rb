class Sample < ApplicationRecord
  validates :capture_time, uniqueness: { scope: :sensor_id, message: "should be unique for sensor_id" }
  validate :capture_time_not_in_future

  scope :by_sensor_id, ->(sensor_id) { where(sensor_id: sensor_id) }
  scope :filter_by_start_time, ->(start_time) { where("capture_time >= (?)", start_time) }
  scope :filter_by_end_time, ->(end_time) { where("capture_time <= (?)", end_time) }

  protected
  def capture_time_not_in_future
    if capture_time.future?
      errors.add(:capture_time, "can not be in future")
    end
  end

end
