# frozen_string_literal: true

class EventsController < ApplicationController
  def show
    @event = current_user.events.find(params[:id])
    @time_range = @event.time_range(time_range_name)
  end

  def new
    starts = starts_at || Time.now.utc
    ends = ends_at || starts + 1.hour
    @event = current_user.events.build(
      starts_at: starts,
      ends_at: ends,
    )
    @time_range = @event.time_range(time_range_name)
  end

  def edit
    @event = current_user.events.find(params[:id])
    @time_range = @event.time_range(time_range_name)
  end

  def create
    @event = current_user.events.build(event_params.merge(
      starts_at: starts_at,
      ends_at: ends_at,
    ))
    @time_range = @event.time_range(time_range_name)

    if @event.save
      redirect_to(
        event_path(@event, @time_range),
        notice: "Event was successfully created.",
      )
    else
      render :new
    end
  end

  def update
    @event = current_user.events.find(params[:id])
    @time_range = @event.time_range(time_range_name)

    attributes = event_params.except(:starts_at, :ends_at)
    attributes[:starts_at] = starts_at if starts_at.present?
    attributes[:ends_at] = ends_at if ends_at.present?

    if (@event.update(attributes))
      redirect_to(
        event_path(@event, @time_range),
        notice: "Event was successfully updated.",
      )
    else
      render :edit
    end
  end

  def destroy
    @event = current_user.events.find(params[:id])
    @time_range = @event.time_range(time_range_name)

    @event.destroy
    redirect_to(
      time_range_path(@time_range),
      notice: "Event was successfully destroyed.",
    )
  end

  private

  def starts_at
    @starts_at ||= Time.use_zone(current_user.time_zone) do
      param_value = params.dig(:event, :starts_at)
      if param_value.present?
        case param_value
        when ActionController::Parameters
          Time.parse(param_value[:date] + "T" + param_value[:time]).utc
        when String
          Time.parse(param_value).utc
        end
      end
    end
  end

  def ends_at
    @ends_at ||= Time.use_zone(current_user.time_zone) do
        param_value = params.dig(:event, :ends_at)
        if param_value.present?
          case param_value
          when ActionController::Parameters
            Time.parse(param_value[:date] + "T" + param_value[:time]).utc
          when String
            Time.parse(param_value).utc
          end
        end
      end
  end

  def time_range_name
    params[:time_range_name]&.to_sym || :day
  end

  def event_path(event, time_range)
    Events::Paths.new(event: event, time_range: time_range_name).path
  end

  def time_range_path(time_range)
    TimeRanges::Paths.new(time_range).path
  end

  def event_params
    params.require(:event).permit(:title, starts_at: {}, ends_at: {})
  end
end
