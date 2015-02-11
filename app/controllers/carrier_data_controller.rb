class CarrierDataController < ApplicationController
  def check_carrier_validity
    respond_to do |format|
      format.json { render :json => CarrierData.carrier_valid?(params[:person][:carrier_data_id]) }
    end
  end
end