class CreateCarrierAverages < ActiveRecord::Migration
  def change
    create_table :carrier_averages do |t|
      t.decimal :vehicle
      t.decimal :driver
      t.decimal :hazmat
      t.string :timeframe

      t.timestamps
    end
  end
end
