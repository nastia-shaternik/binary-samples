require "base64"

class BinarySamplesDecoder

  ENTRY_FIELDS = [ :capture_time, :sensor_id, :light, :soil_moisture, :air_temperature ]

  attr_reader :buffer, :raw_data, :entries_count

  def initialize(buffer, header_length = nil, entry_length = nil)
    @buffer = buffer
    @header_length = header_length || 3
    @entry_length = entry_length || 12
  end

  def perform
    attr_array = []

    unpacked_entries.each do |unpacked_entry|
      attr_array << Hash[ENTRY_FIELDS.zip(unpacked_entry)]
    end

    attr_array
  end

  def raw_data
    @raw_data ||= Base64.decode64(buffer)
  end

  def entries_count
    @entries_count ||= raw_data.unpack(">cn").last
  end

  protected

  def unpacked_entries
    raw_entries_data = raw_data[@header_length..-1]

    entries = []

    current_position = 0

    entries_count.times do
      entry = raw_entries_data[current_position..-1].unpack('Nnnnn')
      entries << entry
      current_position = current_position + @entry_length
    end

    entries
  end
end
