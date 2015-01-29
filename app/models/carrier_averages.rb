# == Schema Information
#
# Table name: carrier_averages
#
#  id         :integer          not null, primary key
#  vehicle    :decimal(10, 2)
#  driver     :decimal(10, 2)
#  hazmat     :decimal(10, 2)
#  timeframe  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CarrierAverages < ActiveRecord::Base
  attr_accessible :driver, :hazmat, :timeframe, :vehicle
  
  validates_presence_of :driver, :hazmat, :timeframe, :vehicle
end
