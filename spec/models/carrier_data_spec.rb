# == Schema Information
#
# Table name: carrier_data
#
#  id               :string(255)      default(""), not null, primary key
#  usdot_number     :string(255)
#  validated        :boolean
#  legal_name       :string(255)
#  dba_name         :string(255)
#  address          :string(255)
#  city             :string(255)
#  state            :string(255)
#  zip              :string(255)
#  trucks           :integer
#  drivers          :integer
#  rating           :string(255)
#  rate_date        :date
#  inspections      :integer
#  crashes          :integer
#  vehicle_oos_rate :integer
#  driver_oos_rate  :integer
#  hazmat_oos_rate  :integer
#  property         :boolean
#  passenger        :boolean
#  household_goods  :boolean
#  broker           :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe CarrierData do
  pending "add some examples to (or delete) #{__FILE__}"
end
