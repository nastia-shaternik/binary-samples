class SamplesCreationService
  class SamplesCreationError < StandardError; end

  # TODO it's not optimized solutions and needs to be reworked
  # Request with ~7782 entries took ~129910ms
  def process(buffer)
    value_hashes = BinarySamplesDecoder.new(buffer).perform

    value_hashes.each do |value_hash|
      value_hash[:capture_time] = DateTime.strptime(value_hash[:capture_time].to_s, '%s')

      sample = Sample.new(value_hash)
      sample.valid?

      raise SamplesCreationError if sample.errors[:capture_time].include? 'cannot be in the future'

      if sample.errors.added? :capture_time, :uniqueness
        Rails.logger.warn "Sample with capture_time already exists."
        next
      end

      sample.save
    end
  end
end
