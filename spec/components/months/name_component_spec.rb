require "rails_helper"

RSpec.describe Months::NameComponent, type: :component do
  it "renders the month's long name" do
    result = render_inline(
      Months::NameComponent.new(
        month: Month.new(
          2020,
          3,
          time_zone: ActiveSupport::TimeZone.new("UTC"),
          user_id: "UNKNOWN"
        )
      )
    )
    expect(result.to_html).to eq("March\n")
  end
end
