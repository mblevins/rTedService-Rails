class DayPower < ActiveRecord::Base
  attr_accessible :day, :pgeWatts, :solarWatts, :waterWatts
end
