require "rails_helper"

RSpec.describe EventsController, type: :controller do
  render_views

  describe "GET new" do
    it "defaults the time range to all day today" do
      Timecop.freeze(Time.utc(2020, 02, 02, 02)) do
        get :new
        expect(assigns(:time_range)).to eq(
          TimeRange.from_date(
            name: :day,
            date: Date.new(2020, 02, 02),
          )
        )
      end
    end

    it "sets the time range based on the starts_at param" do
      get :new, params: { starts_at: Time.utc(2020, 03, 03, 03) }
      expect(assigns(:time_range)).to eq( Day.new(2020, 03, 03))
    end

    it "sets the time range type based on the time_range param" do
      Timecop.freeze(Time.utc(2020, 04, 04, 04)) do
        get :new, params: { time_range: :month }
        expect(assigns(:time_range)).to eq(Month.new(2020, 04))
      end
    end
  end
end
