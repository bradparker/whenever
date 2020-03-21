# frozen_string_literal: true

class Year
  attr_reader :value, :starts_at

  def initialize(value)
    @value = value
    @starts_at = Date.new(value.to_i)
  end

  def prev
    Year.new(value - 1)
  end

  def next
    Year.new(value + 1)
  end

  def months
    @months ||= (1..12).map do |month|
      Month.new(value, month, event_range)
    end
  end

  def to_param
    value.to_s.rjust(4, "0")
  end

  def eql?(other)
    value == other.value
  end

  def ==(other)
    eql?(other)
  end

  def hash
    value.hash
  end

  private

  def event_range
    @event_range ||= EventRange.new(starts_at.all_year)
  end
end
