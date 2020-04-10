# frozen_string_literal: true

class EventRange
  def initialize(range, time_zone:, user_id:)
    @range = range
    @time_zone = time_zone
    @user_id = user_id
  end

  def on(date)
    by_date[date].to_a
  end

  def count(date)
    counts[date].to_i
  end

  private

  attr_reader :user_id, :range, :time_zone

  def starts_at
    @starts_at ||= Time.use_zone(time_zone) do
      first = range.first
      Time.zone.local(first.year, first.month, first.day).utc
    end
  end

  def ends_at
    @ends_at ||= Time.use_zone(time_zone) do
      last = range.last
      Time.zone.local(last.year, last.month, last.day).end_of_day.utc
    end
  end

  def scope
    @scope ||= Event
      .where(user_id: user_id, starts_at: (starts_at..ends_at))
      .or(Event.where(user_id: user_id, ends_at: (starts_at..ends_at)))
  end

  def by_date
    @by_date ||= scope.group_by do |event|
      event.starts_at.in_time_zone(time_zone).to_date
    end
  end

  def counts
    @counts ||= scope.group(
      "date(starts_at at time zone '#{time_zone.tzinfo.identifier.downcase}')"
    ).count
  end
end
