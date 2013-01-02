class CreateTedData < ActiveRecord::Migration
  def change
    create_table :ted_data do |t|
      t.string :mtu
      t.string :mtype
      t.timestamp :cumtime
      t.integer :watts

      t.timestamps
    end
  end
end
