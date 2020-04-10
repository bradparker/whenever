class User < ApplicationRecord
  has_many :events
  has_many :sessions

  validates :username, uniqueness: true, presence: true
  validates :salt, uniqueness: true, presence: true
  validates :verifier, uniqueness: true, presence: true
  validates :time_zone, presence: true

  def year(value)
    Year.new(value, time_zone: time_zone, user_id: id)
  end

  def year_from_date(date)
    Year.from_date(date, time_zone: time_zone, user_id: id)
  end

  def month(year, value)
    Month.new(year, value, time_zone: time_zone, user_id: id)
  end

  def month_from_date(date)
    Month.from_date(date, time_zone: time_zone, user_id: id)
  end

  def week(year, value)
    Week.new(year, value, time_zone: time_zone, user_id: id)
  end

  def week_from_date(date)
    Week.from_date(date, time_zone: time_zone, user_id: id)
  end

  def day(year, month, value)
    Day.new(year, month, value, time_zone: time_zone, user_id: id)
  end

  def day_from_date(date)
    Day.from_date(date, time_zone: time_zone, user_id: id)
  end

  def time_zone
    ActiveSupport::TimeZone[
      TZInfo::Timezone.get(self[:time_zone])
        .period_for_utc(Time.now.utc).utc_offset
    ]
  end
end
