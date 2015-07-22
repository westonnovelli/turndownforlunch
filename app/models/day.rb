class Day < ActiveRecord::Base

  def prev
    yesterday = Day.get_or_create(self.date.yesterday)
    if yesterday.nil?
      self
    else
      yesterday
    end
  end

  def next
    tomorrow = Day.find_by date: self.date.tomorrow
    if tomorrow.nil?
      newday = Day.get_or_create(self.date.tomorrow)
    else
      tomorrow
    end
  end

  def self.get_or_create(date)
    existing_day = Day.find_by date: date
    if existing_day.nil?
      day = Day.new(date: date)
      day.save
      DaysController.sync(Date.today)
      day
    else
      existing_day
    end
  end
end
