require "rails_helper"
require_relative "../generators/date"
require_relative "../generators/event"

RSpec.describe Day do
  describe "#events" do
    generative do
      data (:day) do
        date = Generative.generate(:date)
        time = date.to_time(:utc)
        count = Generative.generate(:integer, {
          min: 2,
          max: 100,
        })

        (1 .. count).each do
          Generative.generate(:event, {
            starts_at: {
              min: time - 1.year,
              max: time + 1.year,
            }
          }).save!
        end
        Generative.generate(:event, {
          starts_at: {
            min: time,
            max: time.end_of_day,
          }
        }).save!

        Day.new(date.year, date.month, date.day)
      end

      it "returns only events for that day" do
        dates = day.events.map do |event|
          event.starts_at.to_date
        end
        expect(dates.uniq).to eq([day.starts_at.to_date])
      end
    end
  end
end
