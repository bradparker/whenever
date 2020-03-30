# frozen_string_literal: true

class Month
  include TimeRange::Naming

  def self.from_date(date, user_id:, event_range: nil)
    new(
      date.year,
      date.month,
      user_id: user_id,
      event_range: event_range,
    )
  end

  attr_reader :year, :value, :starts_at

  def initialize(year, value, user_id:, event_range: nil)
    @year = Year.new(year, user_id: user_id)
    @value = value
    @starts_at = Date.new(year, value)
    @user_id = user_id
    @event_range = event_range
  end

  def prev
    Month.from_date(starts_at.prev_month, user_id: user_id)
  end

  def next
    Month.from_date(starts_at.next_month, user_id: user_id)
  end

  def days
    @days ||= starts_at.all_month.map do |date|
      Day.from_date(
        date,
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
      user_id: user_id,
    )
  end
end
