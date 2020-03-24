require "rails_helper"

RSpec.describe EventsController, type: :controller do
  render_views

  describe "GET new" do
    it "sets the time range based on the event[starts_at] param" do
      get :new, params: {
        time_range_name: :day,
        event: {
          starts_at: Time.utc(2020, 03, 03, 03)
        }
      }
      expect(assigns(:time_range)).to eq(Day.new(2020, 03, 03))
    end

    it "sets the time range type based on the time_range param" do
      Timecop.freeze(Time.utc(2020, 04, 04, 04)) do
        get :new, params: { time_range_name: :month }
        expect(assigns(:time_range)).to eq(Month.new(2020, 04))
      end
    end
  end
end
