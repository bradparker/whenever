class EventRange
  def initialize(range)
    @range = range
  end

  def on(date)
    by_date[date].to_a
  end

  def count(date)
    counts[date].to_i
  end

  private

  attr_reader :range

  def scope
    @scope ||= Event.where(starts_at: range)
  end

  def by_date
    @by_date ||= scope.group_by { |event| event.starts_at.to_date }
  end

  def counts
    @counts ||= scope.group("date(starts_at)").count
  end
end
