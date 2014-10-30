class Token < ActiveRecord::Base

  belongs_to :delivery_man

  # Generate a token for this user
  # If existing, return exists one
  # Otherwise create a new one
  def self.find_or_create(delivery_man_id)
    token = Token.find_by_delivery_man_id(delivery_man_id)
    unless token
      token = Token.create(access_token: SecureRandom.urlsafe_base64,
                        delivery_man_id: delivery_man_id)   
    end
    token
  end

end
