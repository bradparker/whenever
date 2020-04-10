class TimeRangesController < ApplicationController
  def show
    redirect_to TimeRanges::Paths.new(time_range).path
  end

  private

  def time_range
    Time.use_zone(current_user.time_zone) do
      params[:name].classify.constantize.from_date(
        Time.now.to_date,
        time_zone: current_user.time_zone,
        user_id: current_user.id
      )
    end
  end
end
