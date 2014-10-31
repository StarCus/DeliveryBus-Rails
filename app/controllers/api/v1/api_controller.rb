class Api::V1::ApiController < ActionController::Base
  before_filter :api_token_authenticate!

  private

  def api_token_authenticate!
    return _not_authorized unless @token = Token.find_by_access_token(params[:token])
  end

  # Get Current Logged in User
  def current_delivery_man
    if @delivery_man = @token.delivery_man
      @delivery_man
    else
      nil
    end
  end

  def _not_authorized message = "Not Authorized"
    render json: {error: message}, status: 401
  end

end