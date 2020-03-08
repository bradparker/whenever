class MonthsController < ApplicationController
  def show
    @month = Month.new(
      params[:year_id].to_i,
      params[:id].to_i
    )
  end
end
