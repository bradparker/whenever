# frozen_string_literal: true

class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @time_range = @event.time_range(time_range_name)
  end

  def new
    @event = Event.new(starts_at: starts_at)
    @time_range = @event.time_range(time_range_name)
  end

  def edit
    @event = Event.find(params[:id])
    @time_range = @event.time_range(time_range_name)
  end

  def create
    @event = Event.new(event_params)
    @time_range = @event.time_range(time_range_name)

    if @event.save
      redirect_to(
        event_urls(@event, @time_range).path,
        notice: "Event was successfully created.",
      )
    else
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    @time_range = @event.time_range(time_range_name)

    if @event.update(event_params)
      redirect_to(
        event_path(@event, @time_range),
        notice: "Event was successfully updated.",
      )
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @time_range = @event.time_range(time_range_name)

    @event.destroy
    redirect_to(
      time_range_path(@time_range),
      notice: "Event was successfully destroyed.",
    )
  end

  private

  def starts_at
    if params[:starts_at].present?
      Time.parse(params[:starts_at]).utc
    else
      Time.now.utc
    end
  end

  def time_range_name
    params[:time_range]&.to_sym ||
      params.dig(:event, :time_range)&.to_sym ||
      :day
  end

  def event_path(event, time_range)
    Events::Paths.new(id: event.id, time_range: time_range).path
  end

  def time_range_path(time_range)
    TimeRanges::Paths.new(time_range).path
  end

  def event_params
    params.require(:event).permit(:title, :starts_at, :ends_at)
  end
end
