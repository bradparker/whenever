# frozen_string_literal: true

class YearsController < ApplicationController
  def show
    @year = Year.new(params[:id].to_i)
  end
end
