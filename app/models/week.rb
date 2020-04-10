# frozen_string_literal: true

class Week
  include TimeRange::Naming

  def self.from_date(
    date,
    time_zone:,
    user_id:,
    event_range: nil
  )
    new(
      date.cwyear,
      date.cweek,
      time_zone: time_zone,
      user_id: user_id,
      event_range: event_range
    )
  end

  attr_reader :year, :value, :time_zone, :starts_at

  def initialize(year, value, time_zone:, user_id:, event_range: nil)
    @year = Year.new(year, time_zone: time_zone, user_id: user_id)
    @value = value
    @time_zone = time_zone
    @starts_at = Date.commercial(year, value)
    @user_id = user_id
    @event_range = event_range
  end

  def current?
    Time.use_zone(time_zone) do
      Time.zone.now.beginning_of_week.to_date == starts_at
    end
  end

  def prev
    Week.from_date(
      starts_at.prev_week,
      time_zone: time_zone,
      user_id: user_id
    )
  end

  def next
    Week.from_date(
      starts_at.next_week,
      time_zone: time_zone,
      user_id: user_id
    )
  end

  def month
    Month.from_date(
      starts_at,
      time_zone: time_zone,
      user_id: user_id
    )
  end

  def days
    @days ||= starts_at.all_week.map do |date|
      Day.from_date(
        date,
        time_zone: time_zone,
        user_id: user_id,
        event_range: event_range
      )
    end
  end

  def months
    days.map(&:month).uniq
  end

  def days_by_month
    days.group_by(&:month)
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

  def to_param
    value.to_s
  end

  private

  attr_reader :user_id

  def event_range
    @event_range ||= EventRange.new(
      starts_at.all_week,
      time_zone: time_zone,
      user_id: user_id
    )
  end
end
