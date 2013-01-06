class CreateDayHists < ActiveRecord::Migration
  def change
    create_table :day_hists do |t|
      t.date :day
      t.string :mtu
      t.integer :watts

      t.timestamps
    end
  end
end
