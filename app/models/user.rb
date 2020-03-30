class User < ApplicationRecord
  has_many :events
  has_many :sessions

  validates :username, uniqueness: true, presence: true
  validates :salt, uniqueness: true, presence: true
  validates :verifier, uniqueness: true, presence: true

  def year(value)
    Year.new(value, user_id: id)
  end

  def year_from_date(date)
    Year.from_date(date, user_id: id)
  end

  def month(year, value)
    Month.new(year, value, user_id: id)
  end

  def month_from_date(date)
    Month.from_date(date, user_id: id)
  end

  def week(year, value)
    Week.new(year, value, user_id: id)
  end

  def week_from_date(date)
    Week.from_date(date, user_id: id)
  end

  def day(year, month, value)
    Day.new(year, month, value, user_id: id)
  end

  def day_from_date(date)
    Day.from_date(date, user_id: id)
  end
end
