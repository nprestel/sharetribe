class ChangeDateFormatInMyTable < ActiveRecord::Migration
  def up
    change_column :people, :carrier_auth_number, :text
  end

  def down
  end
end
