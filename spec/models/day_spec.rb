require "rails_helper"
require_relative "../generators/date"
require_relative "../generators/event"
require_relative "../generators/user"

RSpec.describe Day do
  describe "#events" do
    generative do
      data (:user) do
        Generative.generate(:user).tap do |user|
          user.save!
        end
      end

      data (:day) do
        date = Generative.generate(:date)
        time = Time.use_zone(user.time_zone) do
          Time.zone.local(date.year, date.month, date.day).utc
        end
        count = Generative.generate(:integer, {
          min: 2,
          max: 100,
        })

        (1 .. count).each do
          Generative.generate(:event, {
            user: user,
            starts_at: {
              min: time - 1.year,
              max: time + 1.year,
            }
          }).save!
        end
        Generative.generate(:event, {
          user: user,
          starts_at: {
            min: time,
            max: time + 1.day,
          }
        }).save!

        Day.new(
          date.year,
          date.month,
          date.day,
          time_zone: user.time_zone,
          user_id: user.id
        )
      end

      it "returns only events for that day" do
        days = day.events.map(&:day)
        expect(days.uniq).to eq([day])
      end
    end
  end
end
