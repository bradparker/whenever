# frozen_string_literal: true

class Year
  include TimeRange::Naming

  def self.from_date(date, user_id:)
    new(date.year, user_id: user_id)
  end

  attr_reader :value, :starts_at

  def initialize(value, user_id:)
    @value = value
    @starts_at = Date.new(value.to_i)
    @user_id = user_id
  end

  def prev
    Year.new(value - 1, user_id: user_id)
  end

  def next
    Year.new(value + 1, user_id: user_id)
  end

  def months
    @months ||= (1..12).map do |month|
      Month.new(
        value,
        month,
        user_id: user_id,
        event_range: event_range
      )
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

  attr_reader :user_id

  def event_range
    @event_range ||= EventRange.new(
      starts_at.all_year,
      user_id: user_id
    )
  end
end
