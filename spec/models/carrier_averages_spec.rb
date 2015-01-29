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

require 'spec_helper'

describe CarrierAverages do
  pending "add some examples to (or delete) #{__FILE__}"
end
