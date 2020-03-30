require "rails_helper"

RSpec.describe Months::LongNameComponent, type: :component do
  it "renders the month's long name" do
    result = render_inline(Months::LongNameComponent.new(month: Month.new(2020, 3, user_id: "UNKNOWN")))
    expect(result.to_html).to eq("March, 2020\n")
  end
end
