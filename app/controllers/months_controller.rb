# frozen_string_literal: true

class MonthsController < ApplicationController
  def show
    @month = current_user.month(
      params[:year_id].to_i,
      params[:id].to_i
    )
  end
end
