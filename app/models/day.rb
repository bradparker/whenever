# frozen_string_literal: true

require "forwardable"

class Day
  include TimeRange::Naming

  def self.from_date(date, time_zone:, user_id:, event_range: nil)
    new(
      date.year,
      date.month,
      date.day,
      time_zone: time_zone,
      user_id: user_id,
      event_range: event_range,
    )
  end

  extend Forwardable
  def_delegators :month, :year

  attr_reader :month, :value, :time_zone

  def initialize(
    year,
    month,
    value,
    time_zone:,
    user_id:,
    event_range: nil
  )
    @month = Month.new(
      year,
      month,
      time_zone: time_zone,
      user_id: user_id
    )
    @value = value
    @time_zone = time_zone
    @user_id = user_id
    @event_range = event_range
  end

  def starts_at
    @starts_at ||= Date.new(year.value, month.value, value)
  end

  def current?
    Time.use_zone(time_zone) do
      Time.zone.now.to_date == starts_at
    end
  end

  def prev
    Day.from_date(
      starts_at.prev_day.to_date,
      time_zone: time_zone,
      user_id: user_id
    )
  end

  def next
    Day.from_date(
      starts_at.next_day.to_date,
      time_zone: time_zone,
      user_id: user_id
    )
  end

  def week
    Week.new(
      starts_at.to_date.cwyear,
      starts_at.to_date.cweek,
      time_zone: time_zone,
      user_id: user_id
    )
  end

  def week_day
    starts_at.to_date.cwday
  end

  def events
    @events ||= event_range.on(starts_at)
  end

  def event_count
    event_range.count(starts_at)
  end

  def to_param
    value.to_s.rjust(2, "0")
  end

  def eql?(other)
    month == other.month && value == other.value
  end

  def ==(other)
    eql?(other)
  end

  def hash
    month.hash ^ value.hash
  end

  private

  attr_reader :user_id

  def event_range
    @event_range ||= EventRange.new(
      [starts_at],
      time_zone: time_zone,
      user_id: user_id,
    )
  end
end
