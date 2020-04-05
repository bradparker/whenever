class Days::TimeMeasureComponent < ViewComponent::Base
  attr_reader :col_start, :col_span, :row_start

  def initialize(row_start: 1, col_start: 1, col_span: 2)
    @col_start = col_start
    @col_span = col_span
    @row_start = row_start
  end

  def beginning_of_day
    @beginning_of_day ||= Time.now.utc.beginning_of_day
  end
end
