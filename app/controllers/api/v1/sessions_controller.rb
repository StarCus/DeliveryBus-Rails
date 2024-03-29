class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_filter :api_token_authenticate!, only: [:create, :login]

  # Register a new delivery_man
  # POST /api/v1/sessions
  # Params 
  # => user: email, password 
  # => delivery_man: phone_number, name
  # def create
  #   user = User.new(user_params)
  #   if user.save
  #     user.delivery_man.update_attributes(delivery_man_params)

  #     render json: {
  #       user: user,
  #       token: Token.find_or_create(user.id),
  #       msg: 'Successful created user.'
  #     }
  #   else
  #     puts "#{user.errors}"
  #     render json: {errors: user.errors}, status: :unprocessable_entity
  #   end
  # end

  # If client already logged in, call this method to update client
  def pull
    puts "Push identifier: #{push_params}"
    if push_params != nil
      device = Device.find_or_create(push_params, current_delivery_man)
      device.login
    end
    render json: {
      delivery_man: current_delivery_man,
      msg: "Success", 
      identifier: "SUCCESS"
    }
  end

  # Login
  # POST /api/v1/sessions/login
  def login
    phone_number = delivery_man_params[:phone_number]
    password = delivery_man_params[:password]
    name = delivery_man_params[:name]

    delivery_man = DeliveryMan.find_by_phone_number(phone_number)
    
    if not delivery_man
      render json: {
        msg: "User does not exist.",
        identifier: "USER_NOT_EXIST"
      }, status: :unprocessable_entity
    elsif not delivery_man.authenticate password 
      render json: {
        msg: "Password incorrect.",
        identifier: "INVALID_PASSWORD"
      }, status: :unauthorized
    else
      token = Token.find_or_create(delivery_man.id)
      device = Device.find_or_create(push_params, delivery_man)
      device.login

      render json: {
        msg: "Success",
        code: "SUCCESS",
        delivery_man: delivery_man,
        token: token
      }
    end
  end

  # Logout
  # DELETE /api/v1/sessions
  def destroy

  end

  private

  def _parse_user(str)
    unless str == nil
      user_data = Base64.decode64(str)
      arr = user_data.split(":")

      # Check if the string indeed has the right pattern
      arr.length == 2 ? status = true : status = false
      { status: status, email: arr[0], password: arr[1] }
    else
      { status: false, email: nil, password: nil }
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def delivery_man_params
    params.require(:delivery_man).permit(:phone_number, :name, :password)
  end

  def device_params
    params.require(:device).permit(:push_identifier)
  end

  def push_params
    params.require(:push_identifier)
  end
end