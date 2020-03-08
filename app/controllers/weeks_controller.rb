class WeeksController < ApplicationController
  def show
    @week = Week.new(
      params[:year_id].to_i,
      params[:id].to_i
    )
  end
end
