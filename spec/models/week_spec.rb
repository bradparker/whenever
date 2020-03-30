require "rails_helper"

RSpec.describe Week do
  def safe_week(year, week)
    begin
      Week.new(year, week, user_id: "UNKNOWN")
    rescue ArgumentError => e
      if e.message != "invalid date"
        raise e
      end
      safe_week(year, week - 1)
    end
  end

  describe "#days" do
    context "for all weeks" do
      generative do
        data (:week) do
          year = Generative.generate(:integer, {
            min: 0,
            max: 9999,
          })
          week = Generative.generate(:integer, {
            min: 1,
            max: 53,
          })
          safe_week(year, week)
        end

        it "always returns seven days" do
          expect(week.days.length).to eq(7)
        end
      end
    end

    context "for the first week of the year" do
      generative do
        data (:week) do
          year = Generative.generate(:integer, {
            min: 0,
            max: 9999,
          })

          Week.new(year, 1, user_id: "UNKNOWN")
        end

        it "returns days in the last week and a half in December the previous year, or the first week and a half of January of that year" do
          week.days.each do |day|
            expect(week.year.value - 1..week.year.value).to cover(day.year.value)
            expect([12, 1]).to include(day.month.value)

            if day.month.value == 12
              expect(20..31).to cover(day.value)
            else
              expect(1..11).to cover(day.value)
            end
          end
        end
      end
    end

    context "for the last week of the year" do
      generative do
        data (:week) do
          year = Generative.generate(:integer, {
            min: 0,
            max: 9999,
          })

          safe_week(year, 53)
        end

        it "returns days in the final week and a half of December of that year, or first week and a half of January the next year" do
          week.days.each do |day|
            expect(week.year.value..week.year.value + 1).to cover(day.year.value)
            expect([12, 1]).to include(day.month.value)

            if day.month.value == 12
              expect(20..31).to cover(day.value)
            else
              expect(1..11).to cover(day.value)
            end
          end
        end
      end
    end

    context "for neither the first nor last week of the year" do
      generative do
        data (:week) do
          year = Generative.generate(:integer, {
            min: 0,
            max: 9999,
          })
          week = Generative.generate(:integer, {
            min: 2,
            max: 51,
          })

          Week.new(year, week, user_id: "UNKNOWN")
        end

        it "returns days who's year must be equal to the week's year" do
          week.days.each do |day|
            expect(week.year.value).to eq(day.year.value)
          end
        end

        it "returns days who's month must be one less than, equal to, or one more than the week's month" do
          week.days.each do |day|
            expect(week.month.value - 1..week.month.value + 1).to cover(day.month.value)
          end
        end
      end
    end
  end
end
