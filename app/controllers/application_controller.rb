class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?, only: [:create]
  protect_from_forgery with: :exception

  before_action :set_cache_headers
  def set_cache_headers
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      rails_admin_path # or any other admin page path
    else
      root_path # or any other default page path
    end
  end


  def authenticate_user!
    unless user_signed_in?
      flash[:alert] = "You need to sign in or sign up before continuing."
    end
  end
  
  def authenticate_bus_owner!
    unless current_user && current_user.bus_owner?
      redirect_to root_path, alert: "You don't have permission to access this page"
    end
  end

  protected

  def configure_permitted_parameters
    if params["user"]["role"] == "0"
    	params["user"]["role"] = "customer"
    	attributes = [:role]
    	devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    else
    	attributes = [:role]
    	devise_parameter_sanitizer.permit(:sign_up, keys: attributes)

    end
	end
end
