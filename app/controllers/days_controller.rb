class DaysController < ApplicationController
  def show
    @day = Day.new(
      params[:year_id].to_i,
      params[:month_id].to_i,
      params[:id].to_i
    )
  end
end
