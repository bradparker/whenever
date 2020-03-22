# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :set_time_range, only: %i[show edit destroy]

  def show; end

  def new
    @event = Event.new(starts_at: Time.parse(params[:starts_at]))
    @time_range = TimeRange.from_date(
      name: params[:time_range],
      date: @event.starts_at.to_date,
    )
  end

  def edit; end

  def create
    @event = Event.new(event_params)
    time_range = TimeRange.from_date(
      name: params.dig(:event, :time_range),
      date: @event.starts_at.to_date,
    )

    if @event.save
      redirect_to(
        event_urls(@event, time_range).path,
        notice: "Event was successfully created.",
      )
    else
      render :new
    end
  end

  def update
    time_range = TimeRange.from_date(
      name: params.dig(:event, :time_range),
      date: @event.starts_at.to_date,
    )
    if @event.update(event_params)
      redirect_to(
        event_urls(@event, time_range).path,
        notice: "Event was successfully updated.",
      )
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to(
      time_range_urls(@event).path,
      notice: "Event was successfully destroyed.",
    )
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_urls(event, time_range)
    Events::Urls.new(
      id: event.id,
      time_range: time_range,
    )
  end

  def set_time_range
    @time_range = TimeRange.from_date(
      name: params[:time_range],
      date: @event.starts_at.to_date,
    )
  end

  def time_range_urls(event)
    TimeRanges::Urls.new(TimeRange.from_date(
      name: params[:time_range],
      date: event.starts_at.to_date,
    ))
  end

  def event_params
    params.require(:event).permit(:title, :starts_at, :duration)
  end
end
