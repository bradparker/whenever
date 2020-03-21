require "rails_helper"

RSpec.describe Days::LinkComponent, type: :component do
  it "renders a link to the provided day" do
    result = render_inline(Days::LinkComponent.new(day: Day.new(2020, 03, 22))) do
      "Some link content"
    end
    expect(result.to_html).to eq(
      "<a href=\"/2020/03/22\">Some link content</a>\n"
    )
  end
end
