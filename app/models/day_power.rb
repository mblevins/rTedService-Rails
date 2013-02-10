class DayPower < ActiveRecord::Base
  attr_accessible :day, :pgeWatts, :solarWatts, :waterWatts
  validates_uniqueness_of :day
end
