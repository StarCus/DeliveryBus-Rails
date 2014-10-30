class Token < ActiveRecord::Base

  belongs_to :delivery_man

  # Generate a token for this user
  # If existing, return exists one
  # Otherwise create a new one
  # def self.find_or_create(user_id)
  #   token = Token.find_by_user_id(user_id)
  #   unless token
  #     token = Token.create(access_token: SecureRandom.urlsafe_base64,
  #                               user_id: user_id)   
  #   end
  #   token
  # end

end
