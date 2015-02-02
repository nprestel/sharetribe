class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :people, :carrier_data_id, :carrier_auth_number
  end

  def down
    # rename back if you need or do something else or do nothing
  end
end
