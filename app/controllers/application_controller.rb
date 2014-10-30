class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :authenticate_user!  
  before_action :custom_authentication!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:role)
  end

  def custom_authentication!
    open_routes = ['/s/','/hotspot/','admin/','active_admin/devise/sessions']
    authenticate_user! unless open_routes.any? { |path| 
      "/#{params[:controller]}/".include? path
    }
  end
end
