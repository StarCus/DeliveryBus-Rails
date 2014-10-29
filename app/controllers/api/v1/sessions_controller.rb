class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_filter :api_token_authenticate!, only: [:create, :login]

  # Register a new user
  # POST /api/v1/sessions
  # Params 
  # => user: email, password 
  # => delivery_man: phone_number, name
  def create
    user = User.new(user_params)
    if user.save
      user.delivery_man.update_attributes(delivery_man_params)

      render json: {
        user: user,
        token: Token.find_or_create(user.id),
        msg: 'Successful created user.'
      }
    else
      puts "#{user.errors}"
      render json: {errors: user.errors}, status: :unprocessable_entity
    end
  end

  # Login
  # POST /api/v1/sessions/login
  def login
    email = user_params[:email]
    password = user_params[:password]

    user = User.find_by_email(email)
    if not user 
      render json: {
        msg: "User does not exist.",
        identifier: "USER_NOT_EXIST"
      }, status: :unprocessable_entity
    elsif not user.valid_password? password 
      render json: {
        msg: "Password incorrect.",
        identifier: "INVALID_PASSWORD"
      }, status: :unauthorized
    else
      token = Token.find_or_create(user.id)

      render json: {
        msg: "Success",
        code: "SUCCESS",
        user: user.as_json,
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
  def user_params
    params.require(:user).permit(:email, :password)
  end

  def delivery_man_params
    params.require(:delivery_man).permit(:phone_number, :name)
  end

end