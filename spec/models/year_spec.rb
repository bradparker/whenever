require "rails_helper"

RSpec.describe Year do
  describe "#months" do
    context "for all years" do
      generative do
        data (:year) do
          year = Generative.generate(:integer, {
            min: 0,
            max: 9999,
          })
          Year.new(year, user_id: "UNKNOWN")
        end

        it "returns the 12 months of the year" do
          expect(year.months.map(&:year).uniq).to eq([year])
          expect(year.months.map(&:value)).to eq([
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
          ])
        end
      end
    end
  end
end
