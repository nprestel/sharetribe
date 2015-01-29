class CreateCarrierData < ActiveRecord::Migration
  def change
    create_table :carrier_data do |t|
      t.string :auth_number
      t.string :usdot_number
      t.string :legal_name
      t.string :dba_name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.integer :trucks
      t.integer :drivers
      t.string :rating
      t.date :rate_date
      t.integer :inspections
      t.integer :crashes
      t.decimal :vehicle_oos_rate
      t.decimal :driver_oos_rate
      t.decimal :hazmat_oos_rate
      t.boolean :property
      t.boolean :passenger
      t.boolean :household_goods
      t.boolean :broker
      t.boolean :validated

      t.timestamps
    end
  end
end
