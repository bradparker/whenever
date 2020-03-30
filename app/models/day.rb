# frozen_string_literal: true

require "forwardable"

class Day
  include TimeRange::Naming

  def self.from_date(date, user_id:, event_range: nil)
    new(
      date.year,
      date.month,
      date.day,
      user_id: user_id,
      event_range: event_range,
    )
  end

  extend Forwardable
  def_delegators :month, :year

  attr_reader :month, :value

  def initialize(
    year,
    month,
    value,
    user_id:,
    event_range: nil
  )
    @month = Month.new(year, month, user_id: user_id)
    @value = value
    @user_id = user_id
    @event_range = event_range
  end

  def starts_at
    Date.new(year.value, month.value, value)
  end

  def prev
    Day.from_date(starts_at.prev_day, user_id: user_id)
  end

  def next
    Day.from_date(starts_at.next_day, user_id: user_id)
  end

  def week
    Week.new(starts_at.cwyear, starts_at.cweek, user_id: user_id)
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
      starts_at.all_day,
      user_id: user_id,
    )
  end
end
