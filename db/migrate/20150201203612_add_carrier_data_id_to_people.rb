class AddCarrierDataIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :carrier_data_id, :integer
  end
end
