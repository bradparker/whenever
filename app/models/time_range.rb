module TimeRange
  def self.from_date(date:, name: :day)
    name.to_s.classify.constantize.from_date(date)
  end

  def self.name(time_range)
    time_range.class.name.downcase.to_sym
  end
end
