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

class CarrierData < ActiveRecord::Base
  
  has_many :people, :autosave => true, :dependent => :destroy
  
  validates_length_of :id, :minimum => 8, :maximum => 8
  # validates_inclusion_of :id, :in => %w(MC mc Mc mC)
  # validates :id, inclusion: %w(MC mc Mc mC)
  
  attr_accessible :id, :address, :auth_number, :broker, :city, :crashes, :dba_name, :driver_oos_rate, :drivers, :hazmat_oos_rate, :household_goods, :inspections, :legal_name, :passenger, :property, :rate_date, :rating, :state, :trucks, :usdot_number, :validated, :vehicle_oos_rate, :zip

  CARRIER_BLACKLIST = YAML.load_file("#{Rails.root}/config/carrier_blacklist.yml")


  def to_param
    id
  end

  def self.find(id)
    super(self.find_by_id(id).try(:id) || id)
  end
  
  def self.carrier_blacklist
    CARRIER_BLACKLIST
  end

  def self.carrier_valid?(carrier_data_id)
     CarrierData.find_by_id(carrier_data_id).present?
  end
  
end
