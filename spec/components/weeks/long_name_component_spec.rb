require "rails_helper"

RSpec.describe Weeks::LongNameComponent, type: :component do
  it "renders the week's long name" do
    result = render_inline(Weeks::LongNameComponent.new(week: Week.new(2020, 9)))
    expect(result.to_html).to eq("Week 9, 2020\n")
  end
end
