class CreateDayPowers < ActiveRecord::Migration
  def change
    create_table :day_powers do |t|
      t.date :day
      t.integer :pgeWatts
      t.integer :solarWatts
      t.integer :waterWatts

      t.timestamps
    end
  end
end
