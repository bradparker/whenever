require "rails_helper"

RSpec.describe Month do
  describe "#weeks" do
    context "for all months" do
      generative do
        data (:month) do
          year = Generative.generate(:integer, {
            min: 0,
            max: 9999,
          })
          month = Generative.generate(:integer, {
            min: 1,
            max: 12,
          })
          Month.new(year, month)
        end

        it "returns between 4 and 6 weeks" do
          expect(4..6).to cover(month.weeks.count)
        end
      end
    end

    context "for January" do
      generative do
        data (:month) do
          year = Generative.generate(:integer, {
            min: 0,
            max: 9999,
          })

          Month.new(year, 1)
        end

        it "may include the final week of the previous year" do
          month.weeks.each do |week|
            expect([51, 52, 53, 1, 2, 3, 4, 5]).to include(week.value)
          end
        end
      end
    end

    context "for December" do
      generative do
        data (:month) do
          year = Generative.generate(:integer, {
            min: 0,
            max: 9999,
          })

          Month.new(year, 12)
        end

        it "may include the first week of the next year" do
          month.weeks.each do |week|
            expect([48, 49, 50, 51, 52, 53, 1]).to include(week.value)
          end
        end
      end
    end

    context "for neither January nor December" do
      generative do
        data (:month) do
          year = Generative.generate(:integer, {
            min: 0,
            max: 9999,
          })
          month = Generative.generate(:integer, {
            min: 2,
            max: 11,
          })

          Month.new(year, month)
        end

        it "returns weeks who's year must be equal to the month's year" do
          month.weeks.each do |week|
            expect(month.year.value).to eq(week.year.value)
          end
        end

        it "returns weeks who's month must be one less than, equal to, or one more than the month's month" do
          month.weeks.each do |week|
            expect(month.value - 1..month.value + 1).to cover(week.month.value)
          end
        end
      end
    end
  end
end
