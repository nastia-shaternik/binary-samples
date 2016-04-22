FactoryGirl.define do
  factory :sample do
    capture_time { DateTime.current - 3.days }
    sensor_id 42
    light { Kernel.rand 10000 }
    soil_moisture { Kernel.rand 500 }
    air_temperature { Kernel.rand 1000 }
  end
end
