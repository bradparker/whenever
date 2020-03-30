# frozen_string_literal: true

class DaysController < ApplicationController
  def show
    @day = current_user.day(
      params[:year_id].to_i,
      params[:month_id].to_i,
      params[:id].to_i
    )
  end
end
