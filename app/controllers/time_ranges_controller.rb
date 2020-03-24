class TimeRangesController < ApplicationController
  def show
    redirect_to TimeRanges::Paths.new(time_range).path
  end

  private

  def time_range
    params[:name].classify.constantize.from_date(Date.today)
  end
end
