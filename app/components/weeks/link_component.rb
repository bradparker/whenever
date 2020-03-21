class Weeks::LinkComponent < ViewComponent::Base
  attr_reader :week

  def initialize(week:)
    @week = week
  end
end
