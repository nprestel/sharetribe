class FixColumnName3 < ActiveRecord::Migration
  def up
    rename_column :carrier_data, :auth_number, :id
  end

  def down
    # rename back if you need or do something else or do nothing
  end
end
