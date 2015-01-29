class AddIsShipperCarrierToPeople < ActiveRecord::Migration
  def change
    add_column :people, :is_shipper_carrier, :string
  end
end
