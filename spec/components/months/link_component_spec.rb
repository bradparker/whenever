require "rails_helper"

RSpec.describe Months::LinkComponent, type: :component do
  it "renders a link to the provided month" do
    result = render_inline(Months::LinkComponent.new(month: Month.new(2020, 3))) do
      "Some link content"
    end
    expect(result.to_html).to eq("<a href=\"/2020/03\">Some link content</a>\n")
  end
end
