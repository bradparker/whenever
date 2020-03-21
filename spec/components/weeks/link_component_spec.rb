require "rails_helper"

RSpec.describe Weeks::LinkComponent, type: :component do
  it "renders a link to the provided week" do
    result = render_inline(Weeks::LinkComponent.new(week: Week.new(2020, 9))) do
      "Some link content"
    end
    expect(result.to_html).to eq(
      "<a href=\"/2020/weeks/9\">Some link content</a>\n"
    )
  end
end
