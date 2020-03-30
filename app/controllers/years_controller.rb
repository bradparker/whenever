# frozen_string_literal: true

class YearsController < ApplicationController
  def show
    @year = current_user.year(params[:id].to_i)
  end
end
