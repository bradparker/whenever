# frozen_string_literal: true

class EventRange
  def initialize(range, user_id:)
    @range = range
    @user_id = user_id
  end

  def on(date)
    by_date[date].to_a
  end

  def count(date)
    counts[date].to_i
  end

  private

  attr_reader :user_id, :range

  def starts_at
    @starts_at ||= range.first
  end

  def ends_at
    @ends_at ||= range.last.end_of_day
  end

  def scope
    @scope ||= Event
      .where(user_id: user_id, starts_at: starts_at..ends_at)
      .or(Event.where(user_id: user_id, ends_at: starts_at..ends_at))
  end

  def by_date
    @by_date ||= scope.group_by { |event| event.starts_at.to_date }
  end

  def counts
    @counts ||= scope.group("date(starts_at)").count
  end
end
