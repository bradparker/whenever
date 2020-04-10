# frozen_string_literal: true

class Month
  include TimeRange::Naming

  def self.from_date(
    date,
    time_zone:,
    user_id:,
    event_range: nil
  )
    new(
      date.year,
      date.month,
      time_zone: time_zone,
      user_id: user_id,
      event_range: event_range,
    )
  end

  attr_reader :year, :value, :time_zone, :starts_at

  def initialize(year, value, time_zone:, user_id:, event_range: nil)
    @year = Year.new(year, time_zone: time_zone, user_id: user_id)
    @value = value
    @time_zone = time_zone
    @starts_at = Date.new(year, value)
    @user_id = user_id
    @event_range = event_range
  end

  def current?
    Time.use_zone(time_zone) do
      Time.zone.now.beginning_of_month.to_date == starts_at
    end
  end

  def prev
    Month.from_date(
      starts_at.prev_month,
      time_zone: time_zone,
      user_id: user_id,
    )
  end

  def next
    Month.from_date(
      starts_at.next_month,
      time_zone: time_zone,
      user_id: user_id,
    )
  end

  def days
    @days ||= starts_at.all_month.map do |date|
      Day.from_date(
        date,
        time_zone: time_zone,
        user_id: user_id,
        event_range: event_range,
      )
    end
  end

  def days_by_week
    days.group_by(&:week)
  end

  def to_param
    value.to_s.rjust(2, "0")
  end

  def eql?(other)
    year == other.year && value == other.value
  end

  def ==(other)
    eql?(other)
  end

  def hash
    year.hash ^ value.hash
  end

  private

  attr_reader :user_id

  def event_range
    @event_range ||= EventRange.new(
      starts_at.all_month,
      time_zone: time_zone,
      user_id: user_id,
    )
  end
end
