class FixColumnName2 < ActiveRecord::Migration
  def up
    rename_column :people, :carrier_auth_number, :carrier_data_id
  end

  def down
    # rename back if you need or do something else or do nothing
  end
end
