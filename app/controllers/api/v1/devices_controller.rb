class Api::V1::DevicesController < Api::V1::ApiController

  # POST /api/v1/devices
  # Assign a device to delivery man for push notifications
  def create
    device = Device.find_or_create(device_params[:push_identifier], current_delivery_man)
    
    render json: device
  end


  private 
  def device_params
    params[:device].permit(:push_identifier)
  end

end