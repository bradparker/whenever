# frozen_string_literal: true

class Year
  include TimeRange::Naming

  def self.from_date(date, time_zone:, user_id:)
    new(date.year, time_zone: time_zone, user_id: user_id)
  end

  attr_reader :value, :time_zone, :starts_at

  def initialize(value, time_zone:, user_id:)
    @value = value
    @time_zone = time_zone
    @starts_at = Date.new(value.to_i)
    @user_id = user_id
  end

  def current?
    Time.use_zone(time_zone) do
      Time.zone.now.beginning_of_year.to_date == starts_at
    end
  end

  def prev
    Year.new(value - 1, time_zone: time_zone, user_id: user_id)
  end

  def next
    Year.new(value + 1, time_zone: time_zone, user_id: user_id)
  end

  def months
    @months ||= (1..12).map do |month|
      Month.new(
        value,
        month,
        time_zone: time_zone,
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
      time_zone: time_zone,
      user_id: user_id
    )
  end
end
