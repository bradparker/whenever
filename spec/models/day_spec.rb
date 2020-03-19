require "rails_helper"

RSpec.describe Day do
  context "when passed an EventRange" do
    context "#events" do
      it "returns the day's events from the provided EventRange" do
        event_0 = Event.create(title: "Event 0", starts_at: Time.utc(2020, 3, 18, 23))
        event_1 = Event.create(title: "Event 1", starts_at: Time.utc(2020, 3, 19, 1))
        event_2 = Event.create(title: "Event 2", starts_at: Time.utc(2020, 3, 19, 2))
        event_3 = Event.create(title: "Event 3", starts_at: Time.utc(2020, 3, 20, 1))
        event_range = EventRange.new(Date.new(2020, 3).all_month)

        day = Day.new(2020, 3, 19, event_range)

        expect(day.events).to eq([event_1, event_2])
      end
    end
  end
end
